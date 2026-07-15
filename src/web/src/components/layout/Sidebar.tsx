import { Link, useLocation } from 'react-router-dom'

interface NavItem {
  label: string
  href: string
  icon: React.ReactNode
}

const defaultNavItems: NavItem[] = [
  {
    label: 'Learning Map',
    href: '/map',
    icon: (
      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
      </svg>
    ),
  },
  {
    label: 'Quiz',
    href: '/quizzes',
    icon: (
      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
      </svg>
    ),
  },
  {
    label: 'Exam',
    href: '/exam',
    icon: (
      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
      </svg>
    ),
  },
  {
    label: 'Mistakes',
    href: '/mistakes',
    icon: (
      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5s3.332.477 4.5 1.253v13C17.832 18.477 16.246 18 14.5 18s-3.332-.477-4.5-1.253" />
      </svg>
    ),
  },
  {
    label: 'Profile',
    href: '/profile',
    icon: (
      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
      </svg>
    ),
  },
]

interface SidebarProps {
  navItems?: NavItem[]
  isOpen: boolean
  onClose: () => void
  showNavItems?: boolean
}

export function Sidebar({ navItems = defaultNavItems, isOpen, onClose, showNavItems = true }: SidebarProps) {
  const location = useLocation()

  function renderNavItems() {
    return navItems.map((item) => {
      const isActive = location.pathname === item.href ||
        (item.href !== '/map' && location.pathname.startsWith(item.href))
      return (
        <Link
          key={item.href}
          to={item.href}
          onClick={onClose}
          className={`flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
            isActive
              ? 'bg-purple-50 text-purple-600'
              : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
          }`}
        >
          <span className={isActive ? 'text-purple-600' : 'text-gray-400'}>
            {item.icon}
          </span>
          <span>{item.label}</span>
        </Link>
      )
    })
  }

  return (
    <>
      {/* Desktop Sidebar */}
      {showNavItems && (
        <aside className="hidden lg:flex lg:flex-col lg:fixed lg:inset-y-0 lg:left-0 lg:z-40 lg:w-64 lg:bg-white lg:border-r lg:border-gray-200">
          <div className="flex flex-col flex-1 min-h-0 pt-16">
            <div className="flex-1 flex flex-col pb-4 overflow-y-auto">
              <nav className="flex-1 px-2 space-y-1">
                {renderNavItems()}
              </nav>
            </div>
          </div>
        </aside>
      )}

      {/* Mobile Drawer */}
      {isOpen && (
        <div className="lg:hidden fixed inset-0 z-[60]">
          {/* Backdrop */}
          <div
            className="fixed inset-0 bg-gray-600 bg-opacity-75 transition-opacity"
            onClick={onClose}
          />
          {/* Drawer panel */}
          <div className="fixed inset-y-0 left-0 flex flex-col w-64 bg-white shadow-xl">
            <div className="flex items-center justify-between h-16 px-4 border-b border-gray-200">
              <span className="text-xl font-bold text-purple-600">NerdQuiz</span>
              <button
                onClick={onClose}
                className="p-2 rounded-lg text-gray-500 hover:bg-gray-100"
              >
                <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            {showNavItems && (
              <div className="flex-1 overflow-y-auto pt-4 pb-4">
                <nav className="px-2 space-y-1">
                  {renderNavItems()}
                </nav>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  )
}
