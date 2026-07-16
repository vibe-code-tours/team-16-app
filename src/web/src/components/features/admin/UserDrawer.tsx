import { useState, useEffect, type ReactNode } from 'react'
import {
  X, RotateCcw, UserX, Mail, Calendar, Clock,
  Zap, Flame, Trophy, BookOpen, GraduationCap, Target,
  TrendingUp, CheckCircle, LayoutDashboard, Activity,
  BarChart3, Brain, FileText,
} from 'lucide-react'
import { Badge } from '../../ui/Badge'
import { Button } from '../../ui/Button'
import { timeAgo } from '../../../lib/timeAgo'
import { useAdminUserDetail } from '../../../hooks/useAdminUserDetail'

interface UserDrawerProps {
  userId: string | null
  onClose: () => void
  onUserUpdated: () => void
}

type Tab = 'overview' | 'activity' | 'performance'

export function UserDrawer({ userId, onClose, onUserUpdated }: UserDrawerProps) {
  const { user, loading, error, deactivate, resetStreak } = useAdminUserDetail(userId)
  const [activeTab, setActiveTab] = useState<Tab>('overview')
  const [showConfirmAction, setShowConfirmAction] = useState<string | null>(null)

  useEffect(() => {
    setActiveTab('overview')
    setShowConfirmAction(null)
  }, [userId])

  if (!userId) return null

  const handleDeactivate = async () => {
    await deactivate()
    setShowConfirmAction(null)
    onUserUpdated()
  }

  const handleResetStreak = async () => {
    await resetStreak()
    setShowConfirmAction(null)
    onUserUpdated()
  }

  return (
    <>
      {/* Backdrop */}
      <div className="fixed inset-0 z-40 bg-black/30" onClick={onClose} />

      {/* Drawer */}
      <div className="fixed inset-y-0 right-0 z-50 w-full max-w-md bg-white shadow-xl flex flex-col md:right-0 md:max-w-lg">
        {loading && !user ? (
          <div className="flex flex-1 items-center justify-center">
            <div className="h-8 w-8 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
          </div>
        ) : error ? (
          <div className="flex flex-1 flex-col items-center justify-center gap-4 p-6">
            <p className="text-red-600">{error}</p>
            <Button variant="outline" onClick={onClose}>Close</Button>
          </div>
        ) : user ? (
          <>
            {/* Header */}
            <div className="border-b border-gray-200 p-6">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-4">
                  {user.avatarUrl ? (
                    <img src={user.avatarUrl} alt="" className="h-12 w-12 rounded-full" />
                  ) : (
                    <div className="flex h-12 w-12 items-center justify-center rounded-full bg-purple-100 text-lg font-medium text-purple-700">
                      {(user.displayName || user.email).charAt(0).toUpperCase()}
                    </div>
                  )}
                  <div>
                    <h2 className="text-lg font-semibold text-gray-900">{user.displayName || 'Unnamed'}</h2>
                    <p className="flex items-center gap-1.5 text-sm text-gray-500">
                      <Mail className="h-3.5 w-3.5" />
                      {user.email}
                    </p>
                    <div className="mt-1.5 flex items-center gap-2">
                      <Badge variant={user.role === 'admin' ? 'info' : user.role === 'deactivated' ? 'error' : 'default'}>
                        {user.role}
                      </Badge>
                      <span className={`inline-flex items-center gap-1 text-xs font-medium ${user.status === 'active' ? 'text-green-700' : 'text-gray-500'}`}>
                        <span className={`h-1.5 w-1.5 rounded-full ${user.status === 'active' ? 'bg-green-500' : 'bg-gray-400'}`} />
                        {user.status === 'active' ? 'Active' : 'Inactive'}
                      </span>
                    </div>
                  </div>
                </div>
                <button onClick={onClose} className="rounded-lg p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-600">
                  <X className="h-5 w-5" />
                </button>
              </div>
            </div>

            {/* Tabs */}
            <div className="flex border-b border-gray-200 px-6">
              {([
                { key: 'overview' as Tab, icon: LayoutDashboard, label: 'Overview' },
                { key: 'activity' as Tab, icon: Activity, label: 'Activity' },
                { key: 'performance' as Tab, icon: BarChart3, label: 'Performance' },
              ]).map(({ key, icon: Icon, label }) => (
                <button
                  key={key}
                  onClick={() => setActiveTab(key)}
                  className={`flex items-center gap-1.5 border-b-2 px-4 py-3 text-sm font-medium transition-colors ${
                    activeTab === key
                      ? 'border-purple-600 text-purple-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  <Icon className="h-4 w-4" />
                  {label}
                </button>
              ))}
            </div>

            {/* Tab Content */}
            <div className="flex-1 overflow-y-auto p-6">
              {activeTab === 'overview' && (
                <div className="space-y-6">
                  <div className="grid grid-cols-3 gap-3">
                    <StatBox icon={<Zap className="h-4 w-4" />} iconColor="text-purple-500" label="Total XP" value={user.totalXp.toLocaleString()} />
                    <StatBox icon={<Flame className="h-4 w-4" />} iconColor="text-orange-500" label="Streak" value={`${user.streakCount}d`} />
                    <StatBox icon={<Trophy className="h-4 w-4" />} iconColor="text-amber-500" label="Best Streak" value={`${user.longestStreak}d`} />
                    <StatBox icon={<BookOpen className="h-4 w-4" />} iconColor="text-blue-500" label="Quizzes" value={String(user.completedQuizzes)} />
                    <StatBox icon={<GraduationCap className="h-4 w-4" />} iconColor="text-indigo-500" label="Exams" value={String(user.completedExams)} />
                    <StatBox icon={<Target className="h-4 w-4" />} iconColor="text-green-500" label="Accuracy" value={user.totalQuizzes > 0 ? `${((user.completedQuizzes / Math.max(user.totalQuizzes, 1)) * 100).toFixed(0)}%` : '—'} />
                    <StatBox icon={<TrendingUp className="h-4 w-4" />} iconColor="text-amber-500" label="Quiz Avg" value={`${user.avgQuizScore.toFixed(1)}%`} />
                    <StatBox icon={<TrendingUp className="h-4 w-4" />} iconColor="text-blue-500" label="Exam Avg" value={`${user.avgExamScore.toFixed(1)}%`} />
                    <StatBox icon={<CheckCircle className="h-4 w-4" />} iconColor="text-emerald-500" label="Pass Rate" value={`${user.examPassRate}%`} />
                  </div>

                  <div className="flex items-center gap-4 text-sm text-gray-500">
                    <span className="flex items-center gap-1.5">
                      <Calendar className="h-3.5 w-3.5" />
                      Joined {user.createdAt ? new Date(user.createdAt).toLocaleDateString() : '—'}
                    </span>
                    <span className="flex items-center gap-1.5">
                      <Clock className="h-3.5 w-3.5" />
                      Active {timeAgo(user.lastLoginAt)}
                    </span>
                  </div>
                </div>
              )}

              {activeTab === 'activity' && (
                <div>
                  {user.recentActivity.length === 0 ? (
                    <p className="text-center text-gray-500">No recent activity</p>
                  ) : (
                    <div className="space-y-3">
                      {user.recentActivity.map((activity, i) => (
                        <div key={i} className="flex items-center justify-between rounded-lg border border-gray-100 p-3">
                          <div className="flex items-center gap-3">
                            <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${
                              activity.type === 'quiz' ? 'bg-amber-50 text-amber-600' : 'bg-blue-50 text-blue-600'
                            }`}>
                              {activity.type === 'quiz' ? <Brain className="h-4 w-4" /> : <FileText className="h-4 w-4" />}
                            </div>
                            <div>
                              <span className={`inline-flex items-center rounded px-1.5 py-0.5 text-xs font-medium ${
                                activity.type === 'quiz' ? 'bg-amber-100 text-amber-700' : 'bg-blue-100 text-blue-700'
                              }`}>
                                {activity.type}
                              </span>
                              <p className="mt-0.5 text-sm font-medium text-gray-900">{activity.topicName}</p>
                            </div>
                          </div>
                          <div className="text-right">
                            <p className="text-sm font-medium text-gray-900">{activity.score}%</p>
                            <p className="flex items-center justify-end gap-1 text-xs text-gray-500">
                              <Clock className="h-3 w-3" />
                              {activity.completedAt ? timeAgo(activity.completedAt) : '—'}
                            </p>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}

              {activeTab === 'performance' && (
                <div className="space-y-4">
                  <PerformanceBar icon={<Brain className="h-4 w-4" />} iconColor="text-amber-500" label="Quiz Performance" value={user.avgQuizScore} barColor="bg-amber-400" />
                  <PerformanceBar icon={<GraduationCap className="h-4 w-4" />} iconColor="text-blue-500" label="Exam Performance" value={user.avgExamScore} barColor="bg-blue-400" />
                  <PerformanceBar icon={<CheckCircle className="h-4 w-4" />} iconColor="text-green-500" label="Exam Pass Rate" value={user.examPassRate} barColor="bg-green-400" />
                </div>
              )}
            </div>

            {/* Actions */}
            <div className="border-t border-gray-200 p-6">
              {showConfirmAction === 'deactivate' ? (
                <div className="space-y-3">
                  <p className="text-sm text-red-600">Deactivate this user? They will not be able to log in.</p>
                  <div className="flex gap-2">
                    <Button size="sm" variant="ghost" onClick={() => setShowConfirmAction(null)}>Cancel</Button>
                    <Button size="sm" className="bg-red-600 text-white hover:bg-red-700" onClick={handleDeactivate}>Confirm Deactivate</Button>
                  </div>
                </div>
              ) : showConfirmAction === 'resetStreak' ? (
                <div className="space-y-3">
                  <p className="text-sm text-gray-700">Reset this user's streak to 0?</p>
                  <div className="flex gap-2">
                    <Button size="sm" variant="ghost" onClick={() => setShowConfirmAction(null)}>Cancel</Button>
                    <Button size="sm" variant="outline" onClick={handleResetStreak}>Confirm Reset</Button>
                  </div>
                </div>
              ) : (
                <div className="flex flex-wrap gap-2">
                  <Button size="sm" variant="outline" onClick={() => setShowConfirmAction('resetStreak')}>
                    <RotateCcw className="mr-1.5 h-3.5 w-3.5" />
                    Reset Streak
                  </Button>
                  {user.role !== 'admin' && (
                    <Button size="sm" variant="ghost" className="text-red-600 hover:bg-red-50 hover:text-red-700" onClick={() => setShowConfirmAction('deactivate')}>
                      <UserX className="mr-1.5 h-3.5 w-3.5" />
                      Deactivate
                    </Button>
                  )}
                </div>
              )}
            </div>
          </>
        ) : null}
      </div>
    </>
  )
}

function StatBox({ icon, iconColor, label, value }: {
  icon: ReactNode
  iconColor: string
  label: string
  value: string
}) {
  return (
    <div className="rounded-lg bg-gray-50 p-3">
      <div className="flex items-center gap-1.5">
        <span className={iconColor}>{icon}</span>
        <p className="text-xs text-gray-500">{label}</p>
      </div>
      <p className="mt-1 text-lg font-semibold text-gray-900">{value}</p>
    </div>
  )
}

function PerformanceBar({ icon, iconColor, label, value, barColor }: {
  icon: ReactNode
  iconColor: string
  label: string
  value: number
  barColor: string
}) {
  return (
    <div className="rounded-lg bg-gray-50 p-4">
      <div className="flex items-center gap-2">
        <span className={iconColor}>{icon}</span>
        <h4 className="text-sm font-medium text-gray-700">{label}</h4>
      </div>
      <div className="mt-3 flex items-end gap-2">
        <div className={`h-3 rounded-l ${barColor}`} style={{ width: `${Math.min(value, 100)}%` }} />
        <span className="text-xs font-medium text-gray-600">{value.toFixed(1)}%</span>
      </div>
    </div>
  )
}
