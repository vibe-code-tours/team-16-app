import { type ReactNode, useState } from 'react'
import { Header } from './Header'
import { Sidebar } from './Sidebar'

interface LayoutProps {
  children: ReactNode
  showSidebar?: boolean
  showHeader?: boolean
}

export function Layout({ children, showSidebar = true, showHeader = true }: LayoutProps) {
  const [sidebarOpen, setSidebarOpen] = useState(false)

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {showHeader && <Header onMenuToggle={() => setSidebarOpen((prev) => !prev)} />}
      <div className="flex">
        <Sidebar
          isOpen={sidebarOpen}
          onClose={() => setSidebarOpen(false)}
          showNavItems={showSidebar}
        />
        <main className={`flex-1 transition-[margin] duration-200 ${showSidebar ? 'lg:ml-64' : ''}`}>
          <div className="p-4 md:p-6 lg:p-8">
            {children}
          </div>
        </main>
      </div>
    </div>
  )
}
