import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

/// FINAL ATTEMPT: A much simpler, token-based fingerprinter.
class TokenizedErrorFingerprinter {
  static String generateFingerprint(String errorMessage, String exceptionType) {
    final normalizedMessage = _normalize(errorMessage);
    final fingerprintInput = '$exceptionType|$normalizedMessage';
    return _sha1Hash(fingerprintInput);
  }

  static String _normalize(String errorMessage) {
    // A more conservative set of stopwords. We keep words that provide structure.
    const stopWords = <String>{
      'a', 'an', 'the', 'is', 'be', 'was', 'were', 'of', 'in', 'on', 'at', 'to', 'from',
      'and', 'or', 'but', 'not', 'has', 'had', 'have', 'do', 'does', 'did', 'for', 'with',
      'by', 'about', 'as', 'into', 'like', 'through', 'after', 'over', 'between', 'out',
      'any', 'all', 'some', 'no', 'my', 'your', 'his', 'her', 'its', 'our', 'their',
      'i', 'you', 'he', 'she', 'it', 'we', 'they', 'me', 'him', 'us', 'them',
      // Keep structural words like 'error', 'exception', 'field', 'value'
    };

    // 1. Sanitize the string: lowercase and remove punctuation/paths.
    final  sanitized = errorMessage
        .toLowerCase()
        // Replace quoted variable content with a placeholder, but keep the quotes
        .replaceAll(RegExp("'[^']+'"), "''")
        .replaceAll(RegExp('"[^"]+"'), '""')
        // Remove directory paths but keep filenames
        .replaceAll(RegExp(r'[\\/](?:[\w\.-]+\/)+'), '/')
        .replaceAll(RegExp(r'[^\w\s\./_-]'), ' '); // Keep file-related chars

    // 2. Tokenize the string and filter out unstable parts.
    final  tokens = sanitized
        .split(' ')
        .where((token) {
          if (token.isEmpty) return false;
          // A token is considered dynamic if it's a number, hex, or a placeholder
          if (double.tryParse(token) != null) return false;
          if (token.startsWith('0x')) return false;
          if (stopWords.contains(token)) return false;
          return true;
        })
        .toList();

    // 3. Re-join the stable keywords.
    return tokens.join(' ');
  }

  static String _sha1Hash(String input) {
    return sha1.convert(utf8.encode(input)).toString();
  }
}

void main() {
  // Use the new fingerprinter for all tests
  const fingerprinter = TokenizedErrorFingerprinter.generateFingerprint;

  group('TokenizedErrorFingerprinter Testing', () {
    test('Test 1: Same logical error, different variables SHOULD have same fingerprint',
        () {
      final fp1 = fingerprinter(
        "LateInitializationError: Field 'd' has not been initialized.",
        'LateInitializationError',
      );
      final fp2 = fingerprinter(
        "LateInitializationError: Field 'username' has not been initialized.",
        'LateInitializationError',
      );

      expect(fp1, equals(fp2));
    });

    test('Test 2: Different TypeError patterns SHOULD have different fingerprints',
        () {
      final fp1 = fingerprinter(
        'Null check operator used on a null value',
        '_TypeError',
      );
      final fp2 = fingerprinter(
        "type 'String' is not a subtype of type 'int' in type cast",
        '_TypeError',
      );

      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 3: Different RangeError patterns SHOULD have different fingerprints',
        () {
      final fp1 = fingerprinter(
        'RangeError (length): Invalid value: Not in inclusive range 0..2: 10',
        'RangeError',
      );
      final fp2 = fingerprinter(
        'RangeError (index): Invalid value: Not in inclusive range 0..5: 10',
        'RangeError',
      );

      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 4: StateError variations SHOULD have different fingerprints', () {
      final fp1 = fingerprinter('Bad state: No element', 'StateError');
      final fp2 = fingerprinter('Bad state: Too many elements', 'StateError');

      expect(fp1, isNot(equals(fp2)));
    });

    test(
        'Test 5: NoSuchMethodError on different methods SHOULD have different fingerprints',
        () {
      final fp1 = fingerprinter(
          "NoSuchMethodError: The getter 'length' was called on null.",
          'NoSuchMethodError',);
      final fp2 = fingerprinter(
          "NoSuchMethodError: The getter 'isEmpty' was called on null.",
          'NoSuchMethodError',);
      final fp3 = fingerprinter(
          "NoSuchMethodError: The method 'add' was called on null.", 'NoSuchMethodError',);

      expect(fp1, isNot(equals(fp2)));
      expect(fp1, isNot(equals(fp3)));
    });

    test('Test 6: Same error in different files SHOULD have same fingerprint', () {
      final fp1 = fingerprinter(
          'RangeError (length): Invalid value: Not in inclusive range 0..2: 10 at /home/user/app1/lib/main.dart:45:12',
          'RangeError',);
      final fp2 = fingerprinter(
          'RangeError (length): Invalid value: Not in inclusive range 0..2: 10 at /home/user/app2/lib/widget.dart:123:8',
          'RangeError',);

      expect(fp1, equals(fp2));
    });
  });

  group('Additional TokenizedErrorFingerprinter Tests', () {
    test('Test 7: NoSuchMethodError variations (setter, operator)', () {
      final fp1 = fingerprinter("NoSuchMethodError: The setter 'value=' was called on null.", 'NoSuchMethodError');
      final fp2 = fingerprinter("NoSuchMethodError: The operator '[]=' was called on null.", 'NoSuchMethodError');
      final fp3 = fingerprinter("NoSuchMethodError: The getter 'length' was called on null.", 'NoSuchMethodError');
      expect(fp1, isNot(equals(fp2)));
      expect(fp1, isNot(equals(fp3)));
    });

    test('Test 8: TypeError variations', () {
      final fp1 = fingerprinter("type 'Null' is not a subtype of type 'String'", '_TypeError');
      final fp2 = fingerprinter("type 'int' is not a subtype of type 'String'", '_TypeError');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 9: Asset loading error', () {
      final fp1 = fingerprinter("Unable to load asset: 'assets/images/logo.png'", 'AssetError');
      final fp2 = fingerprinter("Unable to load asset: 'assets/icons/home.svg'", 'AssetError');
      // The specific asset is important context, so these should be DIFFERENT.
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 10: Network error variations', () {
      final fp1 = fingerprinter('SocketException: OS Error: Connection refused, errno = 111', 'SocketException');
      final fp2 = fingerprinter('HttpException: Connection closed before full header was received', 'HttpException');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 11: FormatException variations', () {
      final fp1 = fingerprinter('FormatException: Unexpected character (at character 1)', 'FormatException');
      final fp2 = fingerprinter('FormatException: Invalid number', 'FormatException');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 12: ArgumentError variations', () {
      final fp1 = fingerprinter('ArgumentError (Invalid argument(s)): Must be greater than 0', 'ArgumentError');
      final fp2 = fingerprinter('ArgumentError (Invalid argument(s): null given)', 'ArgumentError');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 13: RenderFlex overflow error', () {
      final fp1 = fingerprinter('A RenderFlex overflowed by 150 pixels on the bottom.', 'RenderError');
      final fp2 = fingerprinter('A RenderFlex overflowed by 200.5 pixels on the right.', 'RenderError');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 14: More StateError variations', () {
      final fp1 = fingerprinter('Bad state: The stream has already been listened to.', 'StateError');
      final fp2 = fingerprinter('Bad state: Cannot add new events after calling close', 'StateError');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 15: Error with multiple paths', () {
      final fp1 = fingerprinter("Failed to load '/path/one/file.dart' from '/path/two/other.dart'", 'FileLoadError');
      final fp2 = fingerprinter("Failed to load '/a/b/c.dart' from '/d/e/f.dart'", 'FileLoadError');
      expect(fp1, equals(fp2));
    });

    test('Test 16: Error with unicode characters', () {
      final fp1 = fingerprinter("Error: Invalid character 'ü' found", 'UnicodeError');
      final fp2 = fingerprinter("Error: Invalid character 'é' found", 'UnicodeError');
      expect(fp1, equals(fp2));
    });

    test('Test 17: PlatformException', () {
      final fp1 = fingerprinter('PlatformException(channel-error, Unable to establish connection on channel., null, null)', 'PlatformException');
      final fp2 = fingerprinter('PlatformException(some-other-error, Another issue., null, null)', 'PlatformException');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 18: Local vs. Field LateInitializationError', () {
      final fp1 = fingerprinter("LateInitializationError: Field 'myField' has not been initialized.", 'LateInitializationError');
      final fp2 = fingerprinter("LateInitializationError: Local 'myLocal' has not been initialized.", 'LateInitializationError');
      expect(fp1, isNot(equals(fp2)));
    });

    test('Test 19: Complex nested error message', () {
      final fp1 = fingerprinter("Exception: Failed (Error: Invalid state for user 'test-user-1')", 'ComplexError');
      final fp2 = fingerprinter("Exception: Failed (Error: Invalid state for user 'test-user-2')", 'ComplexError');
      expect(fp1, equals(fp2));
    });

    test('Test 20: Another build error', () {
      final fp1 = fingerprinter('Incorrect use of ParentDataWidget. The ParentDataWidget Expanded(flex: 1) wants a RenderFlex parent, but received a RenderConstrainedBox.', 'BuildError');
      final fp2 = fingerprinter('Incorrect use of ParentDataWidget. The ParentDataWidget Flexible(flex: 2) wants a RenderFlex parent, but received a RenderPadding.', 'BuildError');
      expect(fp1, isNot(equals(fp2)));
    });
    
    test('Test 21: Highly similar but different StateErrors', () {
        final fp1 = fingerprinter('Bad state: field is null', 'StateError');
        final fp2 = fingerprinter('Bad state: field is empty', 'StateError');
        expect(fp1, isNot(equals(fp2)));
    });

    test('Test 22: Errors with only numbers changing', () {
        final fp1 = fingerprinter('Error processing item 1 of 100', 'ProcessingError');
        final fp2 = fingerprinter('Error processing item 50 of 200', 'ProcessingError');
        expect(fp1, equals(fp2));
    });

    test('Test 23: Different error codes in message', () {
        final fp1 = fingerprinter('Failed with error code 500', 'HttpError');
        final fp2 = fingerprinter('Failed with error code 404', 'HttpError');
        expect(fp1, equals(fp2));
    });

    test('Test 24: Flutter framework internal assertions', () {
        final fp1 = fingerprinter("'!_dirty': is not true.", '_AssertionError');
        final fp2 = fingerprinter("'owner._debugCurrentBuildTarget == this': is not true.", '_AssertionError');
        expect(fp1, isNot(equals(fp2)));
    });

    test('Test 25: Similar messages, different context', () {
        final fp1 = fingerprinter('Could not find a part of the path /path/one', 'IOError');
        final fp2 = fingerprinter('Could not find a part of the path /path/two', 'IOError');
        expect(fp1, equals(fp2));
    });

    test('Test 26: Very long error messages', () {
        final fp1 = fingerprinter('This is a very long error message that contains a lot of text and some dynamic values like user_id=12345 and another one like session_id=abcde-fghij-klmno', 'LongError');
        final fp2 = fingerprinter('This is a very long error message that contains a lot of text and some dynamic values like user_id=67890 and another one like session_id=pqrst-uvwxy-z1234', 'LongError');
        expect(fp1, equals(fp2));
    });
  });
}
