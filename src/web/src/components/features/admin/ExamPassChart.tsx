import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from 'recharts'

interface ExamPassChartProps {
  passRate: number
  totalAttempts: number
}

const COLORS = ['#22c55e', '#ef4444']

export function ExamPassChart({ passRate, totalAttempts }: ExamPassChartProps) {
  if (totalAttempts === 0) {
    return (
      <div className="flex h-64 items-center justify-center text-gray-500 dark:text-gray-400">
        No exam data yet
      </div>
    )
  }

  const passed = Math.round(totalAttempts * passRate / 100)
  const failed = totalAttempts - passed
  const data = [
    { name: 'Pass', value: passed },
    { name: 'Fail', value: failed },
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
          formatter={(value) => [`${String(value)} exams`]}
        />
        <Legend />
      </PieChart>
    </ResponsiveContainer>
  )
}
