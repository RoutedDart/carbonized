## ADDED Requirements

### Requirement: Plan CarbonInterface parity backlog
The change MUST provide a task list capturing every remaining API gap uncovered by `php_carbon_parity_test.dart` after switching to `CarbonInterface` instances.

#### Scenario: TODOs cover period builders, UTC diffs, and diffForHumans helpers
- **GIVEN** the parity suite highlights missing `*Until`, `diffInUTC*`, and `long/short diffForHumans` helpers
- **WHEN** contributors open `openspec/changes/add-parity-coverage-plan/tasks.md`
- **THEN** they see tasks describing how to implement each group plus validation expectations
