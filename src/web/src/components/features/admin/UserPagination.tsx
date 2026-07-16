import { ChevronLeft, ChevronRight } from 'lucide-react'
import { Button } from '../../ui/Button'

interface UserPaginationProps {
  page: number
  pageSize: number
  total: number
  onPageChange: (page: number) => void
}

export function UserPagination({ page, pageSize, total, onPageChange }: UserPaginationProps) {
  const totalPages = Math.ceil(total / pageSize)
  const start = (page - 1) * pageSize + 1
  const end = Math.min(page * pageSize, total)

  if (total === 0) return null

  return (
    <div className="flex items-center justify-between">
      <p className="text-sm text-gray-600 dark:text-gray-400">
        Showing {start.toLocaleString()}–{end.toLocaleString()} of {total.toLocaleString()} users
      </p>

      <div className="flex items-center gap-2">
        <Button
          variant="ghost"
          size="sm"
          onClick={() => onPageChange(page - 1)}
          disabled={page <= 1}
        >
          <ChevronLeft className="h-4 w-4" />
        </Button>

        {Array.from({ length: Math.min(totalPages, 5) }, (_, i) => {
          let pageNum: number
          if (totalPages <= 5) {
            pageNum = i + 1
          } else if (page <= 3) {
            pageNum = i + 1
          } else if (page >= totalPages - 2) {
            pageNum = totalPages - 4 + i
          } else {
            pageNum = page - 2 + i
          }
          return (
            <button
              key={pageNum}
              onClick={() => onPageChange(pageNum)}
              className={`h-8 w-8 rounded-lg text-sm font-medium transition-colors ${
                pageNum === page
                  ? 'bg-purple-600 text-white'
                  : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700'
              }`}
            >
              {pageNum}
            </button>
          )
        })}

        <Button
          variant="ghost"
          size="sm"
          onClick={() => onPageChange(page + 1)}
          disabled={page >= totalPages}
        >
          <ChevronRight className="h-4 w-4" />
        </Button>
      </div>
    </div>
  )
}
