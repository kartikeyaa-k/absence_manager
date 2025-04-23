/// NOTE: This is currently hardcoded due to time constraints.
/// In a production-grade app, this list should be fetched from the backend
/// via a dedicated `/absence-types` metadata endpoint OR inferred from data.
///
/// The types would then be cached locally
/// and refreshed periodically (e.g., via TTL-based expiry) or via an app-wide
/// config fetch during startup.
///
/// This approach prevents tight coupling between frontend and backend and ensures
/// that if new types are added by the API, the UI automatically adapts.
enum AbsenceTypeFilter { all, vacation, sickness }
