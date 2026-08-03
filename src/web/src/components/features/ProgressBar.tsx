import clsx from "clsx";

type ProgressBarVariant = "solid" | "gradient";

interface ProgressBarProps {
  current: number;
  total: number;
  showLabel?: boolean;
  label?: string;
  variant?: ProgressBarVariant;
}

export function ProgressBar({
  current,
  total,
  showLabel = true,
  label = "Quiz progress",
  variant = "solid",
}: ProgressBarProps) {
  const percentage = Math.round((current / total) * 100);

  return (
    <div className="w-full">
      {showLabel && (
        <div className="flex justify-between text-sm text-gray-600 mb-1">
          <span>
            Question {current} of {total}
          </span>
          <span>{percentage}%</span>
        </div>
      )}
      <div
        className="w-full h-2 bg-gray-200 rounded-full overflow-hidden"
        role="progressbar"
        aria-label={label}
        aria-valuemin={0}
        aria-valuemax={100}
        aria-valuenow={percentage}
      >
        <div
          className={clsx(
            "h-full transition-all duration-300 ease-out",
            percentage === 100 && "bg-green-500",
            percentage < 100 && variant === "solid" && "bg-purple-600",
            percentage < 100 &&
              variant === "gradient" &&
              "bg-linear-to-r from-purple-500 to-purple-600"
          )}
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
}
