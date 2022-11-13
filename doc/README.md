# Architectural Design Guidelines

- Provider package for all the dynamic widgets and data.
- GetIt for dependency injection.

## Rules of Thumb:

a) Any class in the <b> UI </b> directory must not import from services in any case.

b) Any Future must be called only once in the whole lifecycle of the app for static data, and on data changes for dynamic data.

## Steps to Create a new screen.

