interface FooterProps {
  showSidebar?: boolean
}

export function Footer({ showSidebar = true }: FooterProps) {
  const currentYear = new Date().getFullYear()

  return (
    <footer className={`border-t border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 ${showSidebar ? 'lg:ml-64' : 'w-full'}`}>
      <div className={`flex h-14 items-center gap-1 ${showSidebar ? 'px-4 lg:px-6' : 'mx-auto max-w-6xl px-4'}`}>
        <span className="text-lg">🦉</span>
        <span className="text-sm font-semibold text-purple-600 dark:text-purple-400">NerdQuiz</span>
        <span className="text-sm text-gray-500 dark:text-gray-400">
          &copy; {currentYear} All rights reserved.
        </span>
      </div>
    </footer>
  )
}
