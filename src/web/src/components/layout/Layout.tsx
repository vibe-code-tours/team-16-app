import { type ReactNode, useState } from 'react'
import { Header } from './Header'
import { Sidebar } from './Sidebar'
import { Footer } from './Footer'

interface LayoutProps {
  children: ReactNode
  showSidebar?: boolean
  showHeader?: boolean
}

export function Layout({ children, showSidebar = true, showHeader = true }: LayoutProps) {
  const [sidebarOpen, setSidebarOpen] = useState(false)

  return (
    <div className="flex min-h-screen w-full flex-col bg-gray-50 dark:bg-gray-900">
      {showHeader && <Header showSidebar={showSidebar} onMenuToggle={() => setSidebarOpen((prev) => !prev)} />}
      <div className={`flex w-full flex-1${showHeader ? ' pt-16' : ''}`}>
        <Sidebar
          isOpen={sidebarOpen}
          onClose={() => setSidebarOpen(false)}
          showNavItems={showSidebar}
        />
        <main className={`flex-1 overflow-x-hidden${showSidebar ? ' lg:ml-64' : ''}`}>
          <div className="p-4 md:p-6 lg:p-8">
            {children}
          </div>
        </main>
      </div>
      <Footer showSidebar={showSidebar} />
    </div>
  )
}
