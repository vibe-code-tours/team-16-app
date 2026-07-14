import { type ReactNode } from 'react'
import { Header } from './Header'
import { Sidebar } from './Sidebar'

interface LayoutProps {
  children: ReactNode
  showSidebar?: boolean
}

export function Layout({ children, showSidebar = true }: LayoutProps) {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <div className="flex">
        {showSidebar && <Sidebar />}
        <main className={`flex-1 ${showSidebar ? 'lg:ml-64' : ''}`}>
          <div className="p-4 md:p-6 lg:p-8">
            {children}
          </div>
        </main>
      </div>
    </div>
  )
}
