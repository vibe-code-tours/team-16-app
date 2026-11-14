// Full class names are listed so Tailwind can find them at build time.
const PROGRESS_WIDTH_CLASSES = [
  'w-0',
  'w-[10%]',
  'w-[20%]',
  'w-[30%]',
  'w-[40%]',
  'w-1/2',
  'w-[60%]',
  'w-[70%]',
  'w-4/5',
  'w-[90%]',
  'w-full',
] as const

/** Maps a 0–100 percentage to a Tailwind width class, rounded to the nearest 10%. */
export function getProgressWidthClass(percent: number) {
  const index = Math.min(10, Math.max(0, Math.round(percent / 10)))
  return PROGRESS_WIDTH_CLASSES[index]
}
