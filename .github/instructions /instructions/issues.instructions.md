---
applyTo: 'issues/**'
---

# Issue Management Instructions

## Purpose

This instruction file governs the management, documentation, and completion tracking of all issues within the project. It ensures consistent organization, comprehensive documentation, and professional tracking of development progress.

## Issue Directory Structure

### Standard Organization
```
issues/
├── issue1/
│   ├── README.md           # Issue overview and requirements
│   ├── completion.md       # Implementation documentation
│   ├── handoff.md         # Handoff notes (if applicable)
│   ├── artifacts/         # Issue-specific files
│   └── tests/             # Issue-specific tests
├── issue2/
│   └── [same structure]
└── issue[N]/
    └── [same structure]
```

### Naming Conventions
- **Directory names**: `issue[N]` where N is a sequential number (issue1, issue2, etc.)
- **File names**: Use lowercase with hyphens for multi-word files
- **No spaces**: Use hyphens or underscores consistently

## File Templates and Standards

### README.md Template
```markdown
# Issue [N]: [Brief Title]

## Overview
Brief description of the issue, feature, or task.

## Requirements
### Functional Requirements
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

### Technical Requirements
- [ ] Technical constraint 1
- [ ] Technical constraint 2
- [ ] Performance requirement

### Acceptance Criteria
- [ ] Criteria 1
- [ ] Criteria 2
- [ ] Criteria 3

## Context
Additional context, background information, or related issues.

## Priority
- **Priority Level**: [High/Medium/Low]
- **Estimated Effort**: [1-5 points or hours]
- **Dependencies**: [List any dependencies]

## Implementation Notes
Any specific implementation guidance or constraints.

## Resources
- Links to relevant documentation
- Related issues or PRs
- External resources
```

### completion.md Template
```markdown
# Issue [N] Completion Documentation

## Implementation Summary
Brief summary of how the issue was resolved.

## Changes Made
### Files Modified
- `path/to/file1.ext` - Description of changes
- `path/to/file2.ext` - Description of changes

### Files Added
- `path/to/newfile.ext` - Purpose and description

### Files Removed
- `path/to/oldfile.ext` - Reason for removal

## Technical Details
### Architecture Changes
Description of any architectural changes or decisions.

### Key Implementation Details
- Important algorithms or logic
- Design patterns used
- Performance considerations

## Testing
### Tests Added
- Unit tests: Description and location
- Integration tests: Description and location
- Manual testing performed

### Test Results
Summary of test results and coverage.

## Deployment Notes
Any special deployment considerations or steps.

## Performance Impact
Description of performance implications, if any.

## Security Considerations
Any security implications or measures taken.

## Documentation Updates
List of documentation that was updated or should be updated.

## Known Issues
Any known limitations or issues that remain.

## Future Considerations
Suggestions for future improvements or related work.

## Validation
- [ ] All acceptance criteria met
- [ ] Tests pass
- [ ] Code review completed
- [ ] Documentation updated
- [ ] No regression introduced

## Completion Date
[Date when issue was completed]

## Completed By
[Name/identifier of person who completed the issue]
```

### handoff.md Template (Optional)
```markdown
# Issue [N] Handoff Documentation

## Handoff Context
Reason for handoff and context.

## Current State
Description of work completed and current state.

## Remaining Work
### Tasks Remaining
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Blockers
Any blockers or dependencies that need resolution.

## Implementation Notes
Key decisions made and context for future work.

## Resources
Links and resources for the next person taking over.

## Contact Information
How to reach the person handing off for questions.

## Handoff Date
[Date of handoff]

## Handed Off By
[Name/identifier of person handing off]

## Received By
[Name/identifier of person receiving the handoff]
```

## Issue Lifecycle Management

### 1. Issue Creation
1. Create new directory: `issues/issue[N]/`
2. Copy README.md template and fill out completely
3. Assign priority and effort estimates
4. Document all requirements and acceptance criteria

### 2. Issue Assignment
1. Add assignee information to README.md
2. Update priority if needed
3. Note any dependencies or blockers

### 3. Development Phase
1. Keep README.md updated with any requirement changes
2. Document decisions and implementation notes
3. Add artifacts and tests to appropriate subdirectories

### 4. Completion Phase
1. Fill out completion.md with comprehensive documentation
2. Ensure all acceptance criteria are met
3. Update any related documentation
4. Add test results and validation

### 5. Handoff (if applicable)
1. Create handoff.md if issue is being transferred
2. Document current state and remaining work
3. Provide context for the next person

## Quality Standards

### Documentation Quality
- **Complete**: All sections must be filled out appropriately
- **Clear**: Use clear, concise language
- **Current**: Keep documentation up to date
- **Detailed**: Provide sufficient detail for future reference

### Organization Standards
- **Consistent structure**: Follow templates exactly
- **Logical organization**: Group related files together
- **Clean naming**: Use consistent naming conventions
- **No orphaned files**: Every file should have a clear purpose

## Tracking and Reporting

### Progress Tracking
- Use checkboxes in requirements and acceptance criteria
- Update completion status regularly
- Document blockers and dependencies

### Status Indicators
- **Not Started**: README.md exists, no completion.md
- **In Progress**: README.md exists, work has begun
- **Completed**: completion.md exists and validated
- **Handed Off**: handoff.md exists with transfer details

### Metrics Collection
Track the following metrics for project insight:
- Issue completion time
- Complexity vs. effort estimates
- Common blockers and dependencies
- Code quality metrics (tests, coverage)

## Integration with Development Workflow

### Version Control
- Commit issue directory changes with clear commit messages
- Use branch naming that references issue numbers
- Tag releases that complete major issues

### Testing Integration
- Store issue-specific tests in `tests/` subdirectory
- Ensure tests are integrated with main test suite
- Document test coverage and results

### Deployment Integration
- Document deployment implications in completion.md
- Note any configuration changes required
- Track deployment success and any issues

## Best Practices

### Documentation Best Practices
1. **Write for future you**: Assume you'll forget details
2. **Include context**: Explain why decisions were made
3. **Be specific**: Avoid vague descriptions
4. **Link resources**: Include links to relevant information
5. **Update regularly**: Keep documentation current

### Organization Best Practices
1. **One issue per directory**: Don't mix multiple issues
2. **Complete templates**: Fill out all relevant sections
3. **Archive old issues**: Move completed issues to archive if needed
4. **Maintain numbering**: Use sequential numbering for issues

### Communication Best Practices
1. **Clear requirements**: Ensure requirements are unambiguous
2. **Regular updates**: Keep stakeholders informed of progress
3. **Document decisions**: Record important decisions and rationale
4. **Share knowledge**: Make knowledge accessible to team

## Automation and Tools

### Automated Checks
Consider implementing automated checks for:
- Template completeness
- File naming conventions
- Required sections presence
- Link validity

### Integration Tools
- Issue tracking systems integration
- Automated progress reporting
- Notification systems for status changes
- Metrics dashboard creation

## Troubleshooting

### Common Issues
1. **Missing documentation**: Ensure all templates are filled out
2. **Inconsistent naming**: Use standard naming conventions
3. **Unclear requirements**: Refine requirements for clarity
4. **Lost context**: Document decisions and rationale

### Resolution Strategies
1. **Regular reviews**: Conduct regular documentation reviews
2. **Template enforcement**: Use templates consistently
3. **Knowledge sharing**: Share best practices across team
4. **Continuous improvement**: Refine processes based on experience

---

**Remember**: Good issue documentation is an investment in project success. Take time to document thoroughly and maintain organization consistently.