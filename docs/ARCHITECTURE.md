# School Bridge App - Architecture

## Goal
Connect parents and teachers in an organized school environment, replacing scattered WhatsApp/Telegram groups.

## Principles
- **Privacy**: phone numbers and identity data are never exposed between parties; only display names and roles are shared.
- **Subject channels**: one-way publishing channels (summaries, homework) per subject.
- **Scheduled inquiries**: parent-to-teacher inquiries (tickets) are accepted only within each teacher's daily working hours.

## Layers
| Layer | Path | Responsibility |
|-------|------|----------------|
| Core | `lib/core/` | Constants, theme, utilities |
| Models | `lib/models/` | Plain data classes (User, Subject, Announcement, Inquiry) |
| Services | `lib/services/` | API access and authentication |
| Views | `lib/views/` | UI screens by role (auth, parent, teacher) and shared widgets |

## Roles
- **Parent**: browses subjects, reads announcements, submits inquiries during working hours.
- **Teacher**: publishes announcements, manages inbox, sets working hours.

## Data flow
View -> Service -> API; models are parsed in services and passed to views.
