import { useState, useEffect, type FormEvent, type SVGProps } from "react";
import { Link } from "react-router-dom";
import { useAuth } from "../hooks/useAuth";

const WEEKLY_ACTIVITY: Array<{ day: string; value: number; minutes: number }> = [];

const ACHIEVEMENTS: Achievement[] = [
  {
    title: "Quick learner",
    description: "Completed 10 quizzes",
    icon: "zap",
    iconClassName:
      "bg-amber-100 text-amber-600 ring-amber-200 dark:bg-amber-900/30 dark:text-amber-400 dark:ring-amber-700",
  },
  {
    title: "On fire",
    description: "3 day learning streak",
    icon: "flame",
    iconClassName:
      "bg-orange-100 text-orange-600 ring-orange-200 dark:bg-orange-900/30 dark:text-orange-400 dark:ring-orange-700",
  },
  {
    title: "Sharp mind",
    description: "Scored 90% or higher",
    icon: "target",
    iconClassName:
      "bg-emerald-100 text-emerald-600 ring-emerald-200 dark:bg-emerald-900/30 dark:text-emerald-400 dark:ring-emerald-700",
  },
] as const;

export function UserProfile() {
  const { user, session, signOut, updateProfile } = useAuth();

  // Admin gets a different profile view — no XP, streaks, or learner content
  if (user?.role === 'admin') {
    return <AdminProfileView user={user} session={session} signOut={signOut} updateProfile={updateProfile} />;
  }

  return <StudentProfileView user={user} session={session} signOut={signOut} updateProfile={updateProfile} />;
}

/* ── Student Profile View ── */

function StudentProfileView({
  user,
  session,
  signOut,
  updateProfile,
}: ProfileViewProps) {
  const [editingName, setEditingName] = useState(false);
  const [displayName, setDisplayName] = useState(user?.display_name ?? "");
  const [saving, setSaving] = useState(false);

  // Sync displayName with user data when it changes
  useEffect(() => {
    if (user?.display_name !== undefined) {
      setDisplayName(user.display_name ?? "");
    }
  }, [user?.display_name]);
  const [avatarFailed, setAvatarFailed] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const email = session?.user?.email ?? user?.email ?? null;
  const memberSince = formatMemberSince(user?.created_at);
  const learnerName =
    user?.display_name?.trim() || email?.split("@")[0] || "NerdQuiz learner";
  const initials = getInitials(learnerName);
  const totalXp = user?.total_xp ?? 0;
  const streakCount = user?.streak_count ?? 0;
  const levelProgress = getLevelProgress(totalXp);
  const avatarUrl = user?.avatar_url?.startsWith("http")
    ? user.avatar_url
    : null;

  async function handleSaveName(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const trimmedDisplayName = displayName.trim();

    if (!trimmedDisplayName) {
      setError("Display name cannot be empty");
      return;
    }

    setSaving(true);
    setError(null);
    const { error: updateError } = await updateProfile({
      display_name: trimmedDisplayName,
    });

    if (updateError) {
      setError(updateError);
    } else {
      setEditingName(false);
    }
    setSaving(false);
  }

  function handleCancelEdit() {
    setDisplayName(user?.display_name ?? "");
    setEditingName(false);
    setError(null);
  }

  function handleStartEdit() {
    setDisplayName(user?.display_name ?? "");
    setEditingName(true);
    setError(null);
  }

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-6 pb-8">
      <header className="learning-hero-enter flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <div className="mb-2 flex items-center gap-2 text-sm font-semibold text-purple-600 dark:text-purple-400">
            <Icon name="sparkles" className="size-4" aria-hidden="true" />
            Learner dashboard
          </div>
          <h1 className="text-3xl font-bold tracking-tight text-gray-950 dark:text-gray-50 sm:text-4xl">
            Your profile
          </h1>
          <p className="mt-2 max-w-2xl text-gray-500 dark:text-gray-400">
            See your momentum, celebrate milestones, and keep your learning
            streak alive.
          </p>
        </div>
        <span className="inline-flex w-fit items-center gap-2 rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1.5 text-xs font-semibold text-emerald-700 dark:border-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">
          <span
            className="size-2 animate-pulse rounded-full bg-emerald-500"
            aria-hidden="true"
          />
          Profile up to date
        </span>
      </header>

      <ProfileHero
        avatarUrl={avatarUrl}
        avatarFailed={avatarFailed}
        displayName={learnerName}
        initials={initials}
        levelProgress={levelProgress}
        editingName={editingName}
        editableName={displayName}
        saving={saving}
        error={error}
        onAvatarError={() => setAvatarFailed(true)}
        onEditableNameChange={setDisplayName}
        onStartEdit={handleStartEdit}
        onCancelEdit={handleCancelEdit}
        onSaveName={handleSaveName}
      />

      <StatsGrid totalXp={totalXp} streakCount={streakCount} />

      <div className="grid gap-6 lg:grid-cols-[minmax(0,1.65fr)_minmax(280px,0.85fr)] lg:items-start">
        <div className="flex flex-col gap-6">
          <WeeklyActivity />
          <Achievements />
        </div>

        <aside className="flex flex-col gap-6" aria-label="Account details">
          <AccountCard email={email} memberSince={memberSince} />
          <NextGoal />
          <button
            type="button"
            onClick={signOut}
            className="group inline-flex min-h-12 w-full items-center justify-center gap-2 rounded-2xl border border-gray-200 bg-white px-4 py-3 text-sm font-semibold text-gray-600 shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:border-red-200 hover:bg-red-50 hover:text-red-600 hover:shadow-md focus:outline-none focus-visible:ring-2 focus-visible:ring-red-500 focus-visible:ring-offset-2 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:border-red-700 dark:hover:bg-red-900/30 dark:hover:text-red-400"
          >
            <Icon
              name="log-out"
              className="size-4 transition-transform duration-200 group-hover:translate-x-0.5"
              aria-hidden="true"
            />
            Sign out
          </button>
        </aside>
      </div>
    </div>
  );
}

/* ── Admin Profile View ── */

function AdminProfileView({
  user,
  session,
  signOut,
  updateProfile,
}: ProfileViewProps) {
  const [editingName, setEditingName] = useState(false);
  const [displayName, setDisplayName] = useState(user?.display_name ?? "");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (user?.display_name !== undefined) {
      setDisplayName(user.display_name ?? "");
    }
  }, [user?.display_name]);
  const [avatarFailed, setAvatarFailed] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const email = session?.user?.email ?? user?.email ?? null;
  const memberSince = formatMemberSince(user?.created_at);
  const adminName =
    user?.display_name?.trim() || email?.split("@")[0] || "Platform admin";
  const initials = getInitials(adminName);
  const avatarUrl = user?.avatar_url?.startsWith("http")
    ? user.avatar_url
    : null;

  async function handleSaveName(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const trimmedDisplayName = displayName.trim();
    if (!trimmedDisplayName) {
      setError("Display name cannot be empty");
      return;
    }
    setSaving(true);
    setError(null);
    const { error: updateError } = await updateProfile({
      display_name: trimmedDisplayName,
    });
    if (updateError) {
      setError(updateError);
    } else {
      setEditingName(false);
    }
    setSaving(false);
  }

  function handleCancelEdit() {
    setDisplayName(user?.display_name ?? "");
    setEditingName(false);
    setError(null);
  }

  function handleStartEdit() {
    setDisplayName(user?.display_name ?? "");
    setEditingName(true);
    setError(null);
  }

  return (
    <div className="mx-auto flex max-w-4xl flex-col gap-6 pb-8">
      {/* Page header */}
      <header className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <div className="mb-2 flex items-center gap-2 text-sm font-semibold text-indigo-600 dark:text-indigo-400">
            <Icon name="shield-check" className="size-4" aria-hidden="true" />
            Admin area
          </div>
          <h1 className="text-3xl font-bold tracking-tight text-gray-950 dark:text-gray-50 sm:text-4xl">
            Admin profile
          </h1>
          <p className="mt-2 max-w-2xl text-gray-500 dark:text-gray-400">
            Manage the platform and access admin tools from here.
          </p>
        </div>
        <span className="inline-flex w-fit items-center gap-2 rounded-full border border-indigo-200 bg-indigo-50 px-3 py-1.5 text-xs font-semibold text-indigo-700 dark:border-indigo-700 dark:bg-indigo-900/30 dark:text-indigo-400">
          <span
            className="size-2 rounded-full bg-indigo-500"
            aria-hidden="true"
          />
          Profile up to date
        </span>
      </header>

      {/* Admin hero — avatar, name, admin badge */}
      <section className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-indigo-700 via-indigo-600 to-purple-600 p-6 text-white shadow-xl shadow-indigo-200/60 sm:p-8">
        <div
          className="absolute -right-16 -top-20 size-64 rounded-full bg-white/10 blur-sm"
          aria-hidden="true"
        />
        <div
          className="absolute -bottom-28 right-1/4 size-56 rounded-full bg-purple-300/20 blur-2xl"
          aria-hidden="true"
        />

        <div className="relative flex flex-col gap-7 lg:flex-row lg:items-center">
          <div className="flex flex-col gap-5 sm:flex-row sm:items-center">
            <div className="relative w-fit shrink-0">
              <div className="rounded-full bg-white/20 p-1.5 shadow-lg ring-1 ring-white/30">
                {avatarUrl && !avatarFailed ? (
                  <img
                    src={avatarUrl}
                    alt={`${adminName}'s avatar`}
                    className="size-24 rounded-full object-cover sm:size-28"
                    onError={() => setAvatarFailed(true)}
                  />
                ) : (
                  <div className="flex size-24 items-center justify-center rounded-full bg-white text-2xl font-bold text-indigo-700 sm:size-28">
                    {initials}
                  </div>
                )}
              </div>
            </div>

            <div className="min-w-0 flex-1">
              <span className="inline-flex items-center gap-1.5 rounded-full bg-white/15 px-3 py-1 text-xs font-semibold ring-1 ring-white/20 backdrop-blur-sm">
                <Icon
                  name="shield-check"
                  className="size-3.5"
                  aria-hidden="true"
                />
                Platform admin
              </span>

              {editingName ? (
                <form className="mt-3" onSubmit={handleSaveName}>
                  <label htmlFor="admin-display-name" className="sr-only">
                    Display name
                  </label>
                  <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
                    <input
                      id="admin-display-name"
                      type="text"
                      value={displayName}
                      onChange={(event) =>
                        setDisplayName(event.target.value)
                      }
                      className="min-h-11 w-full rounded-xl border border-white/30 bg-white/15 px-4 py-2 text-lg font-bold text-white outline-none backdrop-blur-sm placeholder:text-indigo-100 focus:border-white focus:ring-2 focus:ring-white/40"
                      placeholder="Enter display name"
                      maxLength={50}
                      aria-describedby={error ? "admin-name-error" : undefined}
                      aria-invalid={Boolean(error)}
                      autoComplete="nickname"
                      autoFocus
                    />
                    <div className="flex gap-2">
                      <button
                        type="submit"
                        disabled={saving}
                        className="inline-flex min-h-11 items-center justify-center gap-2 rounded-xl bg-white px-4 py-2 text-sm font-bold text-indigo-700 transition-colors hover:bg-indigo-50 disabled:cursor-wait disabled:opacity-60 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-offset-2 focus-visible:ring-offset-indigo-600"
                      >
                        {saving ? (
                          <span
                            className="size-4 animate-spin rounded-full border-2 border-indigo-300 border-t-indigo-700"
                            aria-hidden="true"
                          />
                        ) : (
                          <Icon
                            name="save"
                            className="size-4"
                            aria-hidden="true"
                          />
                        )}
                        {saving ? "Saving" : "Save"}
                      </button>
                      <button
                        type="button"
                        onClick={handleCancelEdit}
                        disabled={saving}
                        className="inline-flex min-h-11 items-center justify-center rounded-xl bg-white/10 px-3 text-white ring-1 ring-white/30 transition-colors hover:bg-white/20 disabled:opacity-60 focus:outline-none focus-visible:ring-2 focus-visible:ring-white"
                        aria-label="Cancel editing display name"
                      >
                        <Icon name="x" className="size-4" aria-hidden="true" />
                      </button>
                    </div>
                  </div>
                  {error ? (
                    <p
                      id="admin-name-error"
                      role="alert"
                      className="mt-2 text-sm font-medium text-rose-100"
                    >
                      {error}
                    </p>
                  ) : null}
                </form>
              ) : (
                <div className="mt-3 flex flex-wrap items-center gap-3">
                  <h2 className="truncate text-2xl font-bold sm:text-3xl">
                    {adminName}
                  </h2>
                  <button
                    type="button"
                    onClick={handleStartEdit}
                    className="inline-flex size-9 items-center justify-center rounded-xl bg-white/10 text-white ring-1 ring-white/25 transition-all hover:scale-105 hover:bg-white/20 focus:outline-none focus-visible:ring-2 focus-visible:ring-white"
                    aria-label="Edit display name"
                  >
                    <Icon name="pencil" className="size-4" aria-hidden="true" />
                  </button>
                </div>
              )}

              <p className="mt-3 max-w-xl text-sm leading-6 text-white/80">
                Oversee platform health, manage users, and keep NerdQuiz running
                smoothly.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Admin quick links */}
      <section aria-label="Admin tools" className="grid gap-4 sm:grid-cols-2">
        <Link
          to="/admin"
          className="group rounded-2xl border border-gray-200/80 bg-white p-6 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:border-indigo-200 hover:shadow-lg hover:shadow-indigo-100/60 dark:border-gray-700 dark:bg-gray-800 dark:hover:border-indigo-700 dark:hover:shadow-indigo-900/30"
        >
          <div className="flex items-start justify-between gap-4">
            <div>
              <span className="inline-flex items-center gap-1.5 rounded-full bg-indigo-50 px-2.5 py-1 text-xs font-semibold text-indigo-700 ring-1 ring-indigo-100 dark:bg-indigo-900/30 dark:text-indigo-400 dark:ring-indigo-700">
                <Icon name="bar-chart" className="size-3.5" aria-hidden="true" />
                Insights
              </span>
              <h3 className="mt-3 text-xl font-bold text-gray-950 dark:text-gray-50">
                Dashboard
              </h3>
              <p className="mt-2 text-sm leading-6 text-gray-500 dark:text-gray-400">
                View platform stats, active users, quiz completion rates, and
                exam pass rates at a glance.
              </p>
            </div>
            <span className="flex size-11 shrink-0 items-center justify-center rounded-2xl bg-indigo-50 text-indigo-600 ring-1 ring-indigo-100 transition-transform duration-200 group-hover:scale-110 dark:bg-indigo-900/30 dark:text-indigo-400 dark:ring-indigo-700">
              <Icon name="bar-chart" className="size-5" aria-hidden="true" />
            </span>
          </div>
        </Link>

        <Link
          to="/admin/users"
          className="group rounded-2xl border border-gray-200/80 bg-white p-6 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:border-indigo-200 hover:shadow-lg hover:shadow-indigo-100/60 dark:border-gray-700 dark:bg-gray-800 dark:hover:border-indigo-700 dark:hover:shadow-indigo-900/30"
        >
          <div className="flex items-start justify-between gap-4">
            <div>
              <span className="inline-flex items-center gap-1.5 rounded-full bg-purple-50 px-2.5 py-1 text-xs font-semibold text-purple-700 ring-1 ring-purple-100 dark:bg-purple-900/30 dark:text-purple-400 dark:ring-purple-700">
                <Icon name="user" className="size-3.5" aria-hidden="true" />
                Management
              </span>
              <h3 className="mt-3 text-xl font-bold text-gray-950 dark:text-gray-50">
                Users
              </h3>
              <p className="mt-2 text-sm leading-6 text-gray-500 dark:text-gray-400">
                Search users, manage roles, view details, and handle account
                deactivation.
              </p>
            </div>
            <span className="flex size-11 shrink-0 items-center justify-center rounded-2xl bg-purple-50 text-purple-600 ring-1 ring-purple-100 transition-transform duration-200 group-hover:scale-110 dark:bg-purple-900/30 dark:text-purple-400 dark:ring-purple-700">
              <Icon name="user" className="size-5" aria-hidden="true" />
            </span>
          </div>
        </Link>
      </section>

      {/* Account details + sign out */}
      <aside className="flex flex-col gap-6" aria-label="Account details">
        <AccountCard email={email} memberSince={memberSince} />
        <button
          type="button"
          onClick={signOut}
          className="group inline-flex min-h-12 w-full items-center justify-center gap-2 rounded-2xl border border-gray-200 bg-white px-4 py-3 text-sm font-semibold text-gray-600 shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:border-red-200 hover:bg-red-50 hover:text-red-600 hover:shadow-md focus:outline-none focus-visible:ring-2 focus-visible:ring-red-500 focus-visible:ring-offset-2 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:border-red-700 dark:hover:bg-red-900/30 dark:hover:text-red-400"
        >
          <Icon
            name="log-out"
            className="size-4 transition-transform duration-200 group-hover:translate-x-0.5"
            aria-hidden="true"
          />
          Sign out
        </button>
      </aside>
    </div>
  );
}

/* ── Shared types ── */

interface ProfileViewProps {
  user: NonNullable<ReturnType<typeof useAuth>['user']>;
  session: ReturnType<typeof useAuth>['session'];
  signOut: ReturnType<typeof useAuth>['signOut'];
  updateProfile: ReturnType<typeof useAuth>['updateProfile'];
}

interface ProfileHeroProps {
  avatarUrl: string | null;
  avatarFailed: boolean;
  displayName: string;
  initials: string;
  levelProgress: LevelProgress;
  editingName: boolean;
  editableName: string;
  saving: boolean;
  error: string | null;
  onAvatarError: () => void;
  onEditableNameChange: (value: string) => void;
  onStartEdit: () => void;
  onCancelEdit: () => void;
  onSaveName: (event: FormEvent<HTMLFormElement>) => void;
}

function ProfileHero({
  avatarUrl,
  avatarFailed,
  displayName,
  initials,
  levelProgress,
  editingName,
  editableName,
  saving,
  error,
  onAvatarError,
  onEditableNameChange,
  onStartEdit,
  onCancelEdit,
  onSaveName,
}: ProfileHeroProps) {
  return (
    <section className="learning-feature-enter relative overflow-hidden rounded-3xl bg-gradient-to-br from-violet-700 via-purple-600 to-fuchsia-600 p-6 text-white shadow-xl shadow-purple-200/60 sm:p-8">
      <div
        className="absolute -right-16 -top-20 size-64 rounded-full bg-white/10 blur-sm"
        aria-hidden="true"
      />
      <div
        className="absolute -bottom-28 right-1/4 size-56 rounded-full bg-fuchsia-300/20 blur-2xl"
        aria-hidden="true"
      />
      <div
        className="absolute right-10 top-8 hidden rotate-12 text-white/10 lg:block"
        aria-hidden="true"
      >
        <Icon name="trophy" className="size-32" strokeWidth={1.25} />
      </div>

      <div className="relative grid gap-7 lg:grid-cols-[minmax(0,1fr)_minmax(300px,0.55fr)] lg:items-center">
        <div className="flex flex-col gap-5 sm:flex-row sm:items-center">
          <div className="relative w-fit shrink-0">
            <div className="rounded-full bg-white/20 p-1.5 shadow-lg ring-1 ring-white/30">
              {avatarUrl && !avatarFailed ? (
                <img
                  src={avatarUrl}
                  alt={`${displayName}'s avatar`}
                  className="size-24 rounded-full object-cover sm:size-28"
                  onError={onAvatarError}
                />
              ) : (
                <div className="flex size-24 items-center justify-center rounded-full bg-white text-2xl font-bold text-purple-700 sm:size-28">
                  {initials}
                </div>
              )}
            </div>
            <span
              className="absolute -bottom-1 -right-1 inline-flex size-9 items-center justify-center rounded-full bg-amber-400 text-amber-950 shadow-md ring-4 ring-purple-600"
              title={`Level ${levelProgress.level}`}
            >
              <Icon
                name="star"
                className="size-4 fill-current"
                aria-hidden="true"
              />
              <span className="sr-only">Level {levelProgress.level}</span>
            </span>
          </div>

          <div className="min-w-0 flex-1">
            <span className="inline-flex items-center gap-1.5 rounded-full bg-white/15 px-3 py-1 text-xs font-semibold ring-1 ring-white/20 backdrop-blur-sm">
              <Icon
                name="shield-check"
                className="size-3.5"
                aria-hidden="true"
              />
              Level {levelProgress.level} explorer
            </span>

            {editingName ? (
              <form className="mt-3" onSubmit={onSaveName}>
                <label htmlFor="display-name" className="sr-only">
                  Display name
                </label>
                <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
                  <input
                    id="display-name"
                    type="text"
                    value={editableName}
                    onChange={(event) =>
                      onEditableNameChange(event.target.value)
                    }
                    className="min-h-11 w-full rounded-xl border border-white/30 bg-white/15 px-4 py-2 text-lg font-bold text-white outline-none backdrop-blur-sm placeholder:text-purple-100 focus:border-white focus:ring-2 focus:ring-white/40"
                    placeholder="Enter display name"
                    maxLength={50}
                    aria-describedby={error ? "display-name-error" : undefined}
                    aria-invalid={Boolean(error)}
                    autoComplete="nickname"
                    autoFocus
                  />
                  <div className="flex gap-2">
                    <button
                      type="submit"
                      disabled={saving}
                      className="inline-flex min-h-11 items-center justify-center gap-2 rounded-xl bg-white px-4 py-2 text-sm font-bold text-purple-700 transition-colors hover:bg-purple-50 disabled:cursor-wait disabled:opacity-60 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-offset-2 focus-visible:ring-offset-purple-600"
                    >
                      {saving ? (
                        <span
                          className="size-4 animate-spin rounded-full border-2 border-purple-300 border-t-purple-700"
                          aria-hidden="true"
                        />
                      ) : (
                        <Icon
                          name="save"
                          className="size-4"
                          aria-hidden="true"
                        />
                      )}
                      {saving ? "Saving" : "Save"}
                    </button>
                    <button
                      type="button"
                      onClick={onCancelEdit}
                      disabled={saving}
                      className="inline-flex min-h-11 items-center justify-center rounded-xl bg-white/10 px-3 text-white ring-1 ring-white/30 transition-colors hover:bg-white/20 disabled:opacity-60 focus:outline-none focus-visible:ring-2 focus-visible:ring-white"
                      aria-label="Cancel editing display name"
                    >
                      <Icon name="x" className="size-4" aria-hidden="true" />
                    </button>
                  </div>
                </div>
                {error ? (
                  <p
                    id="display-name-error"
                    role="alert"
                    className="mt-2 text-sm font-medium text-rose-100"
                  >
                    {error}
                  </p>
                ) : null}
              </form>
            ) : (
              <div className="mt-3 flex flex-wrap items-center gap-3">
                <h2 className="truncate text-2xl font-bold sm:text-3xl">
                  {displayName}
                </h2>
                <button
                  type="button"
                  onClick={onStartEdit}
                  className="inline-flex size-9 items-center justify-center rounded-xl bg-white/10 text-white ring-1 ring-white/25 transition-all hover:scale-105 hover:bg-white/20 focus:outline-none focus-visible:ring-2 focus-visible:ring-white"
                  aria-label="Edit display name"
                >
                  <Icon name="pencil" className="size-4" aria-hidden="true" />
                </button>
              </div>
            )}

            <p className="mt-3 max-w-xl text-sm leading-6 text-white/80">
              Curious mind, steady progress. You&apos;re building exam-ready
              confidence one lesson at a time.
            </p>
          </div>
        </div>

        <div className="rounded-2xl border border-white/20 bg-white/10 p-5 backdrop-blur-md">
          <div className="flex items-start justify-between gap-4">
            <div>
              <p className="text-xs font-semibold uppercase tracking-[0.18em] text-purple-100">
                Next level
              </p>
              <p className="mt-1 text-xl font-bold">
                {levelProgress.remainingXp} XP to go
              </p>
            </div>
            <span className="flex size-11 items-center justify-center rounded-2xl bg-amber-300 text-amber-900 shadow-lg shadow-purple-950/10">
              <Icon name="trophy" className="size-5" aria-hidden="true" />
            </span>
          </div>
          <div className="mt-5 flex items-center justify-between text-xs font-medium text-purple-100">
            <span>Level {levelProgress.level}</span>
            <span>
              {levelProgress.currentXp} / {levelProgress.xpPerLevel} XP
            </span>
          </div>
          <div
            className="mt-2 h-2.5 overflow-hidden rounded-full bg-purple-950/25"
            role="progressbar"
            aria-label="Progress to next level"
            aria-valuemin={0}
            aria-valuemax={levelProgress.xpPerLevel}
            aria-valuenow={levelProgress.currentXp}
          >
            <div
              className="learning-progress-reveal h-full rounded-full bg-gradient-to-r from-amber-300 to-yellow-200"
              style={{ width: `${levelProgress.percent}%` }}
            />
          </div>
          <p className="mt-3 text-xs leading-5 text-white/70">
            Complete a quiz today to move your progress forward.
          </p>
        </div>
      </div>
    </section>
  );
}

function StatsGrid({
  totalXp,
  streakCount,
}: {
  totalXp: number;
  streakCount: number;
}) {
  const stats: StatItem[] = [
    {
      label: "Total XP",
      value: totalXp.toLocaleString(),
      detail: "",
      icon: "zap",
      color: "amber",
    },
    {
      label: "Day streak",
      value: `${streakCount} days`,
      detail: "",
      icon: "flame",
      color: "orange",
    },
  ];

  return (
    <section
      aria-label="Learning statistics"
      className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4"
    >
      {stats.map((stat) => (
        <StatCard key={stat.label} stat={stat} />
      ))}
    </section>
  );
}

function StatCard({ stat }: { stat: StatItem }) {
  const colorClasses = {
    amber:
      "bg-amber-50 text-amber-600 ring-amber-100 dark:bg-amber-900/30 dark:text-amber-400 dark:ring-amber-700",
    orange:
      "bg-orange-50 text-orange-600 ring-orange-100 dark:bg-orange-900/30 dark:text-orange-400 dark:ring-orange-700",
    purple:
      "bg-purple-50 text-purple-600 ring-purple-100 dark:bg-purple-900/30 dark:text-purple-400 dark:ring-purple-700",
    emerald:
      "bg-emerald-50 text-emerald-600 ring-emerald-100 dark:bg-emerald-900/30 dark:text-emerald-400 dark:ring-emerald-700",
  };
  return (
    <article className="learning-feature-enter group rounded-2xl border border-gray-200/80 bg-white p-5 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:border-purple-200 hover:shadow-lg hover:shadow-purple-100/60 dark:border-gray-700 dark:bg-gray-800 dark:hover:border-purple-700 dark:hover:shadow-purple-900/30">
      <div className="flex items-start justify-between gap-4">
        <div>
          <p className="text-sm font-medium text-gray-500 dark:text-gray-400">
            {stat.label}
          </p>
          <p className="mt-1 text-2xl font-bold text-gray-950 dark:text-gray-50">
            {stat.value}
          </p>
        </div>
        <span
          className={`flex size-11 items-center justify-center rounded-2xl ring-1 transition-transform duration-200 group-hover:scale-110 ${colorClasses[stat.color]}`}
        >
          <Icon name={stat.icon} className="size-5" aria-hidden="true" />
        </span>
      </div>
      <p className="mt-4 flex items-center gap-1.5 text-xs font-semibold text-emerald-600 dark:text-emerald-400">
        <Icon name="bar-chart" className="size-3.5" aria-hidden="true" />
        {stat.detail}
      </p>
    </article>
  );
}

function WeeklyActivity() {
  return (
    <section
      className="learning-feature-enter rounded-3xl border border-gray-200/80 bg-white p-5 shadow-sm sm:p-6 dark:border-gray-700 dark:bg-gray-800"
      aria-labelledby="weekly-activity-title"
    >
      <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">
            Momentum
          </p>
          <h2
            id="weekly-activity-title"
            className="mt-1 text-xl font-bold text-gray-950 dark:text-gray-50"
          >
            Weekly activity
          </h2>
          <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
            {WEEKLY_ACTIVITY.length > 0
              ? `You studied ${Math.round(WEEKLY_ACTIVITY.reduce((sum, d) => sum + d.minutes, 0) / 60)}h ${WEEKLY_ACTIVITY.reduce((sum, d) => sum + d.minutes, 0) % 60}m this week. Keep it going!`
              : 'Activity data will appear here once you start studying.'}
          </p>
        </div>
        <span className="inline-flex w-fit items-center gap-2 rounded-full bg-purple-50 px-3 py-1.5 text-xs font-semibold text-purple-700 dark:bg-purple-900/30 dark:text-purple-400">
          <Icon name="calendar" className="size-3.5" aria-hidden="true" />
          Last 7 days
        </span>
      </div>

      <div
        className="mt-8 grid h-48 grid-cols-7 items-end gap-2 sm:gap-4"
        aria-label="Minutes studied each day"
      >
        {WEEKLY_ACTIVITY.length === 0 ? (
          <div className="col-span-7 flex items-center justify-center text-sm text-gray-400 dark:text-gray-500">
            No activity data yet
          </div>
        ) : WEEKLY_ACTIVITY.map((item, index) => (
          <div
            key={item.day}
            className="group flex h-full flex-col items-center justify-end gap-2"
          >
            <span className="text-xs font-bold text-purple-700 dark:text-purple-400 opacity-0 transition-opacity group-hover:opacity-100 group-focus-within:opacity-100">
              {item.minutes}m
            </span>
            <div className="relative flex w-full flex-1 items-end justify-center overflow-hidden rounded-xl bg-purple-50 dark:bg-purple-900/30">
              <div
                className="learning-progress-reveal w-full rounded-xl bg-gradient-to-t from-purple-600 to-fuchsia-400 transition-all duration-200 group-hover:from-purple-700 group-hover:to-fuchsia-500"
                style={{
                  height: `${item.value}%`,
                  animationDelay: `${index * 45}ms`,
                }}
                title={`${item.day}: ${item.minutes} minutes`}
              />
            </div>
            <span
              className={`text-xs font-semibold ${item.day === "Sun" ? "text-purple-700 dark:text-purple-400" : "text-gray-400 dark:text-gray-500"}`}
            >
              {item.day}
            </span>
          </div>
        ))}
      </div>
    </section>
  );
}

function Achievements() {
  return (
    <section
      className="learning-feature-enter rounded-3xl border border-gray-200/80 bg-white p-5 shadow-sm sm:p-6 dark:border-gray-700 dark:bg-gray-800"
      aria-labelledby="achievements-title"
    >
      <div className="flex items-center justify-between gap-4">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">
            Milestones
          </p>
          <h2
            id="achievements-title"
            className="mt-1 text-xl font-bold text-gray-950 dark:text-gray-50"
          >
            Recent achievements
          </h2>
        </div>
        <span className="text-sm font-semibold text-gray-400 dark:text-gray-500">
          3 unlocked
        </span>
      </div>

      <div className="mt-5 grid gap-3 md:grid-cols-3">
        {ACHIEVEMENTS.map((achievement) => {
          return (
            <article
              key={achievement.title}
              className="group rounded-2xl border border-gray-100 bg-gray-50/80 p-4 transition-all duration-200 hover:border-purple-200 hover:bg-purple-50/50 dark:border-gray-700 dark:bg-gray-900/80 dark:hover:border-purple-700 dark:hover:bg-purple-900/30"
            >
              <div
                className={`flex size-11 items-center justify-center rounded-2xl ring-1 transition-transform duration-200 group-hover:-rotate-6 group-hover:scale-110 ${achievement.iconClassName}`}
              >
                <Icon
                  name={achievement.icon}
                  className="size-5"
                  aria-hidden="true"
                />
              </div>
              <h3 className="mt-4 font-bold text-gray-900 dark:text-gray-100">
                {achievement.title}
              </h3>
              <p className="mt-1 text-xs leading-5 text-gray-500 dark:text-gray-400">
                {achievement.description}
              </p>
            </article>
          );
        })}
      </div>
    </section>
  );
}

function AccountCard({
  email,
  memberSince,
}: {
  email: string | null;
  memberSince: string;
}) {
  return (
    <section
      className="learning-feature-enter rounded-3xl border border-gray-200/80 bg-white p-5 shadow-sm sm:p-6 dark:border-gray-700 dark:bg-gray-800"
      aria-labelledby="account-title"
    >
      <div className="flex items-center justify-between gap-3">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">
            Personal
          </p>
          <h2
            id="account-title"
            className="mt-1 text-xl font-bold text-gray-950 dark:text-gray-50"
          >
            Account
          </h2>
        </div>
        <span className="flex size-10 items-center justify-center rounded-2xl bg-purple-50 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400">
          <Icon name="user" className="size-5" aria-hidden="true" />
        </span>
      </div>

      <dl className="mt-5 space-y-4">
        <AccountDetail
          icon="mail"
          label="Email"
          value={email ?? "Not available"}
        />
        <AccountDetail icon="clock" label="Member since" value={memberSince} />
      </dl>
    </section>
  );
}

function AccountDetail({
  icon,
  label,
  value,
}: {
  icon: IconName;
  label: string;
  value: string;
}) {
  return (
    <div className="flex items-start gap-3">
      <span className="mt-0.5 flex size-9 shrink-0 items-center justify-center rounded-xl bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400">
        <Icon name={icon} className="size-4" aria-hidden="true" />
      </span>
      <div className="min-w-0">
        <dt className="text-xs font-medium text-gray-400 dark:text-gray-500">
          {label}
        </dt>
        <dd className="mt-0.5 break-all text-sm font-semibold text-gray-800 dark:text-gray-200">
          {value}
        </dd>
      </div>
    </div>
  );
}

function NextGoal() {
  return (
    <section
      className="learning-feature-enter overflow-hidden rounded-3xl border border-amber-200 bg-gradient-to-br from-amber-50 to-orange-50 p-5 shadow-sm sm:p-6 dark:border-amber-700 dark:bg-gray-800"
      aria-labelledby="next-goal-title"
    >
      <div className="flex items-start justify-between gap-3">
        <div>
          <span className="inline-flex items-center gap-1.5 rounded-full bg-white/80 px-2.5 py-1 text-xs font-semibold text-amber-700 ring-1 ring-amber-200 dark:bg-gray-700 dark:text-amber-400 dark:ring-amber-700">
            <Icon name="award" className="size-3.5" aria-hidden="true" />
            Almost there
          </span>
          <h2
            id="next-goal-title"
            className="mt-3 text-lg font-bold text-gray-950 dark:text-gray-50"
          >
            Quiz champion
          </h2>
          <p className="mt-1 text-sm leading-6 text-gray-600 dark:text-gray-400">
            Complete 2 more quizzes to unlock your next badge.
          </p>
        </div>
        <span className="text-4xl" aria-hidden="true">
          🏆
        </span>
      </div>
      <div
        className="mt-5 h-2 overflow-hidden rounded-full bg-amber-200/70 dark:bg-amber-900/30"
        role="progressbar"
        aria-label="Quiz champion achievement progress"
        aria-valuemin={0}
        aria-valuemax={10}
        aria-valuenow={8}
      >
        <div className="learning-progress-reveal h-full w-4/5 rounded-full bg-gradient-to-r from-amber-500 to-orange-500" />
      </div>
      <div className="mt-2 flex items-center justify-between text-xs font-semibold text-amber-800 dark:text-amber-400">
        <span>8 of 10 quizzes</span>
        <span>80%</span>
      </div>
      <Link
        to="/quizzes"
        className="group mt-5 inline-flex min-h-11 w-full items-center justify-center gap-2 rounded-xl bg-gray-950 px-4 py-2.5 text-sm font-bold text-white transition-all hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2 dark:bg-white dark:text-gray-900 dark:hover:bg-purple-600"
      >
        Continue learning
        <Icon
          name="chevron-right"
          className="size-4 transition-transform group-hover:translate-x-0.5"
          aria-hidden="true"
        />
      </Link>
    </section>
  );
}

function Icon({ name, ...props }: IconProps) {
  let content;

  switch (name) {
    case "award":
      content = (
        <>
          <circle cx="12" cy="8" r="6" />
          <path d="M8.2 13.4 7 22l5-3 5 3-1.2-8.6" />
        </>
      );
      break;
    case "bar-chart":
      content = (
        <>
          <path d="M4 20V10" />
          <path d="M10 20V4" />
          <path d="M16 20v-7" />
          <path d="M22 20H2" />
        </>
      );
      break;
    case "book-open":
      content = (
        <>
          <path d="M2 4.5A2.5 2.5 0 0 1 4.5 2H11v18H4.5A2.5 2.5 0 0 0 2 22Z" />
          <path d="M22 4.5A2.5 2.5 0 0 0 19.5 2H13v18h6.5A2.5 2.5 0 0 1 22 22Z" />
        </>
      );
      break;
    case "calendar":
      content = (
        <>
          <rect x="3" y="5" width="18" height="16" rx="2" />
          <path d="M16 3v4M8 3v4M3 10h18" />
          <path d="M8 14h.01M12 14h.01M16 14h.01M8 18h.01M12 18h.01" />
        </>
      );
      break;
    case "chevron-right":
      content = <path d="m9 18 6-6-6-6" />;
      break;
    case "clock":
      content = (
        <>
          <circle cx="12" cy="12" r="9" />
          <path d="M12 7v5l3 2" />
        </>
      );
      break;
    case "flame":
      content = (
        <path d="M12 22c4.4 0 8-3.4 8-7.8 0-3.2-1.7-6.1-4.7-8.7.1 2.1-.8 3.7-2.1 4.6.2-3.7-1.7-6.4-4.6-8.1.2 3-1.5 5.1-3.1 7.1C4.1 10.8 4 12.6 4 14.2 4 18.6 7.6 22 12 22Z" />
      );
      break;
    case "log-out":
      content = (
        <>
          <path d="M10 17l5-5-5-5M15 12H3" />
          <path d="M14 3h5a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-5" />
        </>
      );
      break;
    case "mail":
      content = (
        <>
          <rect x="3" y="5" width="18" height="14" rx="2" />
          <path d="m3 7 9 6 9-6" />
        </>
      );
      break;
    case "pencil":
      content = (
        <>
          <path d="m4 20 4.5-1 10.8-10.8a2 2 0 0 0-2.8-2.8L5.7 16.2Z" />
          <path d="m14.5 7.5 2.8 2.8" />
        </>
      );
      break;
    case "save":
      content = (
        <>
          <path d="M5 3h12l3 3v15H4V4a1 1 0 0 1 1-1Z" />
          <path d="M8 3v6h8V3M8 21v-7h8v7" />
        </>
      );
      break;
    case "shield-check":
      content = (
        <>
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10Z" />
          <path d="m9 12 2 2 4-4" />
        </>
      );
      break;
    case "sparkles":
      content = (
        <>
          <path d="m12 3-1.2 3.5L7 8l3.8 1.5L12 13l1.2-3.5L17 8l-3.8-1.5Z" />
          <path d="m5 14-.8 2.2L2 17l2.2.8L5 20l.8-2.2L8 17l-2.2-.8ZM19 13l-.8 2.2L16 16l2.2.8L19 19l.8-2.2L22 16l-2.2-.8Z" />
        </>
      );
      break;
    case "star":
      content = (
        <path d="m12 2.8 2.8 5.7 6.3.9-4.5 4.4 1 6.2-5.6-3-5.6 3 1-6.2-4.5-4.4 6.3-.9Z" />
      );
      break;
    case "target":
      content = (
        <>
          <circle cx="12" cy="12" r="9" />
          <circle cx="12" cy="12" r="5" />
          <circle cx="12" cy="12" r="1" />
        </>
      );
      break;
    case "trophy":
      content = (
        <>
          <path d="M8 4h8v5a4 4 0 0 1-8 0Z" />
          <path d="M8 6H4v1a4 4 0 0 0 4 4M16 6h4v1a4 4 0 0 1-4 4M12 13v5M8 21h8M9 18h6" />
        </>
      );
      break;
    case "user":
      content = (
        <>
          <circle cx="12" cy="8" r="4" />
          <path d="M4 21a8 8 0 0 1 16 0" />
        </>
      );
      break;
    case "x":
      content = <path d="M6 6l12 12M18 6 6 18" />;
      break;
    case "zap":
      content = <path d="M13 2 4 14h7l-1 8 9-12h-7Z" />;
      break;
  }

  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={2}
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      {content}
    </svg>
  );
}

function formatMemberSince(createdAt?: string | null) {
  if (!createdAt) return "Recently joined";

  const date = new Date(createdAt);
  if (Number.isNaN(date.getTime())) return "Recently joined";

  return new Intl.DateTimeFormat(undefined, {
    month: "long",
    year: "numeric",
  }).format(date);
}

function getInitials(name: string) {
  const initials = name
    .trim()
    .split(/\s+/)
    .slice(0, 2)
    .map((part) => part[0])
    .join("")
    .toUpperCase();

  return initials || "NQ";
}

function getLevelProgress(totalXp: number): LevelProgress {
  const xpPerLevel = 250;
  const safeXp = Math.max(totalXp, 0);
  const level = Math.floor(safeXp / xpPerLevel) + 1;
  const currentXp = safeXp % xpPerLevel;
  const remainingXp = xpPerLevel - currentXp;

  return {
    level,
    currentXp,
    remainingXp,
    xpPerLevel,
    percent: Math.round((currentXp / xpPerLevel) * 100),
  };
}

interface LevelProgress {
  level: number;
  currentXp: number;
  remainingXp: number;
  xpPerLevel: number;
  percent: number;
}

type IconName =
  | "award"
  | "bar-chart"
  | "book-open"
  | "calendar"
  | "chevron-right"
  | "clock"
  | "flame"
  | "log-out"
  | "mail"
  | "pencil"
  | "save"
  | "shield-check"
  | "sparkles"
  | "star"
  | "target"
  | "trophy"
  | "user"
  | "x"
  | "zap";

interface IconProps extends SVGProps<SVGSVGElement> {
  name: IconName;
}

interface Achievement {
  title: string;
  description: string;
  icon: IconName;
  iconClassName: string;
}

interface StatItem {
  label: string;
  value: string;
  detail: string;
  icon: IconName;
  color: "amber" | "orange" | "purple" | "emerald";
}
