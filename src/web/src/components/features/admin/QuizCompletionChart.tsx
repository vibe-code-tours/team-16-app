import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from 'recharts'

interface QuizCompletionChartProps {
  completed: number
  total: number
}

const COLORS = ['#22c55e', '#ef4444']

export function QuizCompletionChart({ completed, total }: QuizCompletionChartProps) {
  if (total === 0) {
    return (
      <div className="flex h-64 items-center justify-center text-gray-500 dark:text-gray-400">
        No quiz data yet
      </div>
    )
  }

  const notCompleted = total - completed
  const data = [
    { name: 'Completed', value: completed },
    { name: 'Not Completed', value: notCompleted },
  ]

  return (
    <ResponsiveContainer width="100%" height={240}>
      <PieChart>
        <Pie
          data={data}
          cx="50%"
          cy="50%"
          innerRadius={50}
          outerRadius={80}
          paddingAngle={2}
          dataKey="value"
        >
          {data.map((_, index) => (
            <Cell key={`cell-${index}`} fill={COLORS[index]} />
          ))}
        </Pie>
        <Tooltip
          contentStyle={{
            backgroundColor: '#fff',
            border: '1px solid #e5e7eb',
            borderRadius: '8px',
            fontSize: '14px',
          }}
          formatter={(value) => [`${String(value)} sessions`]}
        />
        <Legend />
      </PieChart>
    </ResponsiveContainer>
  )
}
