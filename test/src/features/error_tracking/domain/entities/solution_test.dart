import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/domain/entities/solution.dart';

void main() {
  group('Solution', () {
    test('props', () {
      const solution = Solution(
        id: '1',
        codes: 'code snippet',
        humanDescription: 'description',
        date: '2023-01-01',
        upvotes: 10,
        downvotes: 2,
        isVerified: true,
        environment: SolutionEnvironment(
          projectName: 'project',
          flutterVersion: '2.0.0',
          dartVersion: '2.12.0',
          platform: 'web',
        ),
        url: 'http://example.com',
        comments: [],
      );

      expect(
        solution.props,
        [
          '1',
          'code snippet',
          'description',
          '2023-01-01',
          10,
          2,
          true,
          solution.environment,
          'http://example.com',
          <String>[],
        ],
      );
    });
  });
}
