import { useEffect } from 'react'
import { useFocusTrap } from '../../hooks/useFocusTrap'
import { Button } from '../ui/Button'

interface LevelUpDialogProps {
  open: boolean
  level: number
  onClose: () => void
}

/** Modal announcing a new level. Focus-trapped and dismissable with Escape or the button. */
export function LevelUpDialog({ open, level, onClose }: LevelUpDialogProps) {
  const dialogRef = useFocusTrap(open)

  useEffect(() => {
    if (!open) return

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose()
    }

    document.addEventListener('keydown', handleKeyDown)
    return () => document.removeEventListener('keydown', handleKeyDown)
  }, [open, onClose])

  if (!open) return null

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4">
      <div
        ref={dialogRef}
        role="dialog"
        aria-modal="true"
        aria-labelledby="level-up-dialog-title"
        aria-describedby="level-up-dialog-message"
        className="w-full max-w-sm rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-6 text-center shadow-lg"
      >
        <div className="mb-3 text-5xl" aria-hidden="true">🎉</div>
        <h2 id="level-up-dialog-title" className="mb-2 text-2xl font-bold text-gray-900 dark:text-gray-100">
          Level up!
        </h2>
        <p id="level-up-dialog-message" className="mb-6 text-gray-600 dark:text-gray-400">
          You reached level {level}. Keep the streak going!
        </p>
        <Button onClick={onClose} className="w-full">
          Keep going
        </Button>
      </div>
    </div>
  )
}
