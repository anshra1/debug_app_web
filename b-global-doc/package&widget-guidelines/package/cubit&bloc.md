# Code Guidelines Template

## Basic Information
- **Name**: Cubit or Bloc
- **Type**: StateManagement

## Implementation Rules

### MUST DO ✅
1. Always use buildWhen with BlocBuilder
   ```dart
   // ❌ Bad: Rebuilds on every state change
   BlocBuilder<UserCubit, UserState>(
     builder: (context, state) {
       return Text(state.username);
     },
   )

   // ✅ Good: Only rebuilds when username changes
   BlocBuilder<UserCubit, UserState>(
     buildWhen: (previous, current) => 
       previous.username != current.username,
     builder: (context, state) {
       return Text(state.username);
     },
   )
   
   BlocListener<AuthCubit, AuthState>(
         listenWhen: (_, current) => current is AuthError,
         listener: (context, state) {
           if (state case AuthError(message: final msg)) {
             showErrorDialog(context, msg);
           }
         },
       ),
 
   ```

2. Always use sealed class for creating state class
   ```dart


   // ✅ Good: Using sealed class
   sealed class AuthState {
     const AuthState();
   }
   
   final class AuthInitial extends AuthState {
     const AuthInitial();
   }
   
   final class AuthLoading extends AuthState {
     const AuthLoading();
   }
   

   // ✅ Usage in UI with pattern matching
   BlocBuilder<AuthCubit, AuthState>(
     builder: (context, state) => switch(state) {
       AuthInitial() => LoginForm(),
       AuthLoading() => CircularProgressIndicator(),
       AuthSuccess(user: final user) => UserDashboard(user: user),
       AuthError(message: final message) => ErrorView(message: message),
     },
   )
   ```

### NEVER DO ❌
1. Anti-pattern 1
   ```dart
   // Example of what not to do and why
   ```
2. Anti-pattern 2
   ```dart
   // Another example of what to avoid and why
   ```

## Usage Guide

### Basic Implementation
```dart
// Minimal working example
```

### Advanced Implementation
```dart
// Complex implementation with all features
```

## Performance Considerations
1. **Memory Management**
   ```dart
   // Example of proper memory handling
   ```

2. **State Management** [if applicable]
   ```dart
   // Example of state handling
   ```

3. **Cleanup Required**
   ```dart
   // Example of proper cleanup
   ```

## Common Pitfalls
1. Issue: [Description]
   ```dart
   // Example of the issue
   // Solution to the issue
   ```

## Related Components
- Component 1: How it's used together
- Component 2: How it's used together

## Quick Reference
```dart
// Most common usage pattern
// Copy-paste ready
```

---
Last Updated: [2025-08-25] 