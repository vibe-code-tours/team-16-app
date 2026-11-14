import { cn } from '../../lib/cn'

interface ConfettiPiece {
  id: number
  className: string
}

// Static class strings so Tailwind picks up every position, delay and colour at build time.
const CONFETTI_PIECES: ConfettiPiece[] = [
  { id: 1, className: 'left-[4%] bg-primary-500 [animation-delay:0ms]' },
  { id: 2, className: 'left-[12%] bg-xp-gold [animation-delay:150ms]' },
  { id: 3, className: 'left-[20%] bg-xp-green [animation-delay:300ms]' },
  { id: 4, className: 'left-[28%] bg-sky-400 [animation-delay:80ms]' },
  { id: 5, className: 'left-[36%] bg-pink-500 [animation-delay:220ms]' },
  { id: 6, className: 'left-[44%] bg-primary-400 [animation-delay:360ms]' },
  { id: 7, className: 'left-[52%] bg-xp-gold [animation-delay:40ms]' },
  { id: 8, className: 'left-[60%] bg-xp-green [animation-delay:260ms]' },
  { id: 9, className: 'left-[68%] bg-sky-400 [animation-delay:120ms]' },
  { id: 10, className: 'left-[76%] bg-pink-500 [animation-delay:320ms]' },
  { id: 11, className: 'left-[84%] bg-primary-500 [animation-delay:190ms]' },
  { id: 12, className: 'left-[92%] bg-xp-gold [animation-delay:60ms]' },
]

/**
 * Decorative CSS-only confetti burst. Hidden from assistive tech and switched off
 * entirely under prefers-reduced-motion (see `.celebration-confetti` in index.css).
 */
export function Celebration() {
  return (
    <div className="celebration-confetti" aria-hidden="true" data-testid="celebration">
      {CONFETTI_PIECES.map((piece) => (
        <span key={piece.id} className={cn('confetti-piece', piece.className)} />
      ))}
    </div>
  )
}
