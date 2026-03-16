# Mobile SuperApp Kit — Описание

## Что это такое

Mobile SuperApp Kit — это кастомный набор шаблонов и правил для Cypilot, адаптированный под разработку мобильного приложения Constructor. Кит реализует многоуровневую иерархию документации с полной трассировкой требований от бизнес-целей до кода.

## Проблема, которую мы решаем

При разработке мобильного SuperApp возникает сложность в управлении требованиями:

1. **Платформа** (SuperApp) имеет общие требования (аутентификация, push-уведомления, deep links)
2. **SubApp'ы** (Student, Proctor, Groups) имеют свои специфические требования
3. **Экраны и функции** детализируют требования SubApp до конкретных UI/UX спецификаций
4. **Код** должен быть связан с требованиями для проверки покрытия

Стандартный SDLC kit Cypilot поддерживает только один уровень (система → фичи). Нам нужна каскадная структура.

## Что мы создали

### 1. Четырёхуровневая иерархия PRD

```
L0: Platform PRD (Shared Kernel)
    ├── Authentication (SSO, Apple, E-Devlet)
    ├── Push Notification Infrastructure
    ├── Deep Link Routing
    └── NFRs (Performance, Security, Compliance)

L1: SubApp PRD (Student, Proctor, Groups)
    ├── Courses, Assignments, Calendar
    ├── Notifications UI
    └── Communication (Inbox, Announcements)

L2: Epic PRD (Screens, Capabilities, Flows)
    ├── Notification History Screen
    ├── Course Catalog Screen
    └── Assignment Flow

L3: Feature Spec (CDSL)
    ├── Notification Badge
    ├── Notification List
    └── Mark All as Read
```

### 2. Каскадная трассировка требований

Каждое требование на нижнем уровне ссылается на родительское:

```
Platform FR: cpt-superapp-fr-inapp-notifications
    │
    │ refined-by (уточняется в контексте SubApp)
    ▼
SubApp FR: cpt-student-fr-notifications
    │
    │ detailed-by (детализируется до конкретного экрана)
    ▼
Epic FR: cpt-student-epic-notification-history-fr-badge
    │
    │ specified-by (специфицируется в CDSL)
    ▼
Feature: cpt-student-feature-notification-badge
    │
    │ implemented-by (реализуется в коде)
    ▼
Code: @cpt-impl:cpt-student-feature-notification-badge
```

### 3. Шаблоны документации

**PRD шаблоны:**
- `PRD-SUBAPP.md` — для SubApp с таблицей "Traces To Platform"
- `PRD-EPIC.md` — для экранов с таблицей "Traces To SubApp"

**DESIGN шаблоны:**
- `DESIGN-PLATFORM.md` — архитектура платформы (KMP, Native vs WebView)
- `DESIGN-SUBAPP.md` — модули SubApp (KMP, Android, iOS)
- `DESIGN-EPIC.md` — компоненты экрана (MVI, Use Cases)

**Другие шаблоны:**
- `DECOMPOSITION-*.md` — декомпозиция на каждом уровне
- `FEATURE-MOBILE.md` — CDSL спецификация с платформ-секциями
- `IMPL-KMP/ANDROID/IOS.md` — референсы на код

### 4. Правила валидации

Кит включает автоматические проверки:

| Правило | Описание |
|---------|----------|
| platform-fr-coverage | Каждый Platform FR должен быть refined в SubApp |
| subapp-fr-coverage | Каждый SubApp FR должен быть detailed в Epic |
| epic-fr-coverage | Каждый Epic FR должен быть specified в Feature |
| feature-impl-coverage | Каждый Feature должен иметь @cpt-impl в коде |

### 5. Именование идентификаторов

| Уровень | Паттерн | Пример |
|---------|---------|--------|
| Platform | `cpt-{platform}-fr-{slug}` | `cpt-superapp-fr-offline` |
| SubApp | `cpt-{subapp}-fr-{slug}` | `cpt-student-fr-notifications` |
| Epic | `cpt-{subapp}-epic-{epic}-fr-{slug}` | `cpt-student-epic-home-fr-badge` |
| Feature | `cpt-{subapp}-feature-{slug}` | `cpt-student-feature-daily-goal` |

## Как это помогает

1. **Прозрачность**: Видно, какие бизнес-требования покрыты, какие нет
2. **Навигация**: Можно пройти от кода до бизнес-цели и обратно
3. **Контроль**: Валидация предупреждает о "осиротевших" требованиях
4. **Onboarding**: Новые разработчики понимают структуру проекта
5. **Review**: PM и архитекторы видят полную картину требований

## Пример использования

### Задача: Добавить экран истории уведомлений

1. **Проверяем Platform PRD** — есть `cpt-superapp-fr-inapp-notifications`
2. **Создаём SubApp FR** в Student PRD:
   ```markdown
   <!-- @cpt:id cpt-student-fr-notifications -->
   **Traces To:** `cpt-superapp-fr-inapp-notifications` (refines)
   ```
3. **Создаём Epic PRD** для Notification History:
   ```markdown
   <!-- @cpt:id cpt-student-epic-notification-history-fr-badge -->
   **Traces To:** `cpt-student-fr-notifications` (details)
   ```
4. **Запускаем валидацию**:
   ```bash
   cpt validate --check=subapp-fr-coverage
   ```

## Установка

```bash
cd mobile-superapp
./cypilot/kits/mobile-superapp/install.sh
```

Скрипт создаст симлинк в папку китов Cypilot и (опционально) обновит `artifacts.toml`.

## Откат

```bash
./cypilot/kits/mobile-superapp/uninstall.sh
```

Стандартный SDLC kit остаётся нетронутым.

---

**Версия:** 2.0  
**Дата:** Март 2026  
**Автор:** Constructor Mobile Team
