# Claude Code Spec-Driven Development

This project implements Kiro-style Spec-Driven Development for Claude Code using hooks and slash commands.

## Project Context

### Project Steering
- Product overview: `.kiro/steering/product.md`
- Technology stack: `.kiro/steering/tech.md`
- Project structure: `.kiro/steering/structure.md`
- Custom steering docs for specialized contexts

### Active Specifications
- Current spec: Check `.kiro/specs/` for active specifications
- Use `/kiro:spec-status [feature-name]` to check progress

## Development Guidelines
- Think in English, but generate responses in Japanese (思考は英語、回答の生成は日本語で行うように)

## Spec-Driven Development Workflow

### Phase 0: Steering Generation (Recommended)

#### Kiro Steering (`.kiro/steering/`)
```
/kiro:steering               # Intelligently create or update steering documents
/kiro:steering-custom        # Create custom steering for specialized contexts
```

**Steering Management:**
- **`/kiro:steering`**: Unified command that intelligently detects existing files and handles them appropriately. Creates new files if needed, updates existing ones while preserving user customizations.

**Note**: For new features or empty projects, steering is recommended but not required. You can proceed directly to spec-requirements if needed.

### Phase 1: Specification Creation
```
/kiro:spec-init [feature-name]           # Initialize spec structure only
/kiro:spec-requirements [feature-name]   # Generate requirements → Review → Edit if needed
/kiro:spec-design [feature-name]         # Generate technical design → Review → Edit if needed
/kiro:spec-tasks [feature-name]          # Generate implementation tasks → Review → Edit if needed
```

### Phase 2: Progress Tracking
```
/kiro:spec-status [feature-name]         # Check current progress and phases
```

## Spec-Driven Development Workflow

Kiro's spec-driven development follows a strict **3-phase approval workflow**:

### Phase 1: Requirements Generation & Approval
1. **Generate**: `/kiro:spec-requirements [feature-name]` - Generate requirements document
2. **Review**: Human reviews `requirements.md` and edits if needed
3. **Approve**: Manually update `spec.json` to set `"requirements": true`

### Phase 2: Design Generation & Approval
1. **Generate**: `/kiro:spec-design [feature-name]` - Generate technical design (requires requirements approval)
2. **Review**: Human reviews `design.md` and edits if needed
3. **Approve**: Manually update `spec.json` to set `"design": true`

### Phase 3: Tasks Generation & Approval
1. **Generate**: `/kiro:spec-tasks [feature-name]` - Generate implementation tasks (requires design approval)
2. **Review**: Human reviews `tasks.md` and edits if needed
3. **Approve**: Manually update `spec.json` to set `"tasks": true`

### Implementation
Only after all three phases are approved can implementation begin.

**Key Principle**: Each phase requires explicit human approval before proceeding to the next phase, ensuring quality and accuracy throughout the development process.

## Development Rules

1. **Consider steering**: Run `/kiro:steering` before major development (optional for new features)
2. **Follow the 3-phase approval workflow**: Requirements → Design → Tasks → Implementation
3. **Manual approval required**: Each phase must be explicitly approved by human review
4. **No skipping phases**: Design requires approved requirements; Tasks require approved design
5. **Update task status**: Mark tasks as completed when working on them
6. **Keep steering current**: Run `/kiro:steering` after significant changes
7. **Check spec compliance**: Use `/kiro:spec-status` to verify alignment

## Automation

This project uses Claude Code hooks to:
- Automatically track task progress in tasks.md
- Check spec compliance
- Preserve context during compaction
- Detect steering drift

### Task Progress Tracking

When working on implementation:
1. **Manual tracking**: Update tasks.md checkboxes manually as you complete tasks
2. **Progress monitoring**: Use `/kiro:spec-status` to view current completion status
3. **TodoWrite integration**: Use TodoWrite tool to track active work items
4. **Status visibility**: Checkbox parsing shows completion percentage

## Getting Started

1. Initialize steering documents: `/kiro:steering`
2. Create your first spec: `/kiro:spec-init [your-feature-name]`
3. Follow the workflow through requirements, design, and tasks

## Kiro Steering Details

Kiro-style steering provides persistent project knowledge through markdown files:

### Core Steering Documents
- **product.md**: Product overview, features, use cases, value proposition
- **tech.md**: Architecture, tech stack, dev environment, commands, ports
- **structure.md**: Directory organization, code patterns, naming conventions

### Custom Steering
Create specialized steering documents for:
- API standards
- Testing approaches
- Code style guidelines
- Security policies
- Database conventions
- Performance standards
- Deployment workflows

### Inclusion Modes
- **Always Included**: Loaded in every interaction (default)
- **Conditional**: Loaded for specific file patterns (e.g., `"*.test.js"`)
- **Manual**: Loaded on-demand with `#filename` reference

## Kiro Steering Configuration

### Current Steering Files
The `/kiro:steering` command manages these files automatically. Manual updates to this section reflect changes made through steering commands.

### Active Steering Files
- `product.md`: Always included - Product context and business objectives
- `tech.md`: Always included - Technology stack and architectural decisions
- `structure.md`: Always included - File organization and code patterns

### Custom Steering Files
<!-- Added by /kiro:steering-custom command -->
<!-- Example entries:
- `api-standards.md`: Conditional - `"src/api/**/*"`, `"**/*api*"` - API design guidelines
- `testing-approach.md`: Conditional - `"**/*.test.*"`, `"**/spec/**/*"` - Testing conventions
- `security-policies.md`: Manual - Security review guidelines (reference with @security-policies.md)
-->

### Usage Notes
- **Always files**: Automatically loaded in every interaction
- **Conditional files**: Loaded when working on matching file patterns
- **Manual files**: Reference explicitly with `@filename.md` syntax when needed
- **Updating**: Use `/kiro:steering` or `/kiro:steering-custom` commands to modify this configuration

・日本語でレスポンスすること
・常に最高のパフォーマンスを出すこと
・実装前に似たような処理がないか探し、参考にすること。特に規約はしっかり守ること。
・最後に動作確認やlint, format,型チェックまで行うこと
・動作確認はウェブアプリの場合、PlaywrightMCPを使うこと
・並列で実行しても問題ないタスクは並列で実行すること
・タスク完了後、もし今後タスクを遂行する上で役立ちそうな知見があれば、CLAUDE.local.mdに追記すること
・タスクを完了するか、ユーザーにメッセージを返すときに、最後に terminal-notifier -title "タイトル" -subtitle "サブタイトル" -message "Hi👋" -sound Pop コマンドを 1 回だけ実行します。

