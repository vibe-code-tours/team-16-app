import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import type { TopicEngagement } from '../../../types'

interface TopicScoreChartProps {
  data: TopicEngagement[]
}

export function TopicScoreChart({ data }: TopicScoreChartProps) {
  if (data.length === 0) {
    return (
      <div className="flex h-64 items-center justify-center text-gray-500">
        No score data yet
      </div>
    )
  }

  const formatted = data.map((d) => ({
    ...d,
    avgScore: Number(d.avgScore.toFixed(1)),
  }))

  return (
    <ResponsiveContainer width="100%" height={280}>
      <BarChart data={formatted} layout="vertical" margin={{ top: 5, right: 20, left: 80, bottom: 5 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" horizontal={false} />
        <XAxis
          type="number"
          domain={[0, 100]}
          tick={{ fontSize: 12 }}
          tickLine={false}
          axisLine={{ stroke: '#d1d5db' }}
          tickFormatter={(v) => `${v}%`}
        />
        <YAxis
          type="category"
          dataKey="topicName"
          tick={{ fontSize: 12 }}
          tickLine={false}
          axisLine={{ stroke: '#d1d5db' }}
          width={75}
        />
        <Tooltip
          contentStyle={{
            backgroundColor: '#fff',
            border: '1px solid #e5e7eb',
            borderRadius: '8px',
            fontSize: '14px',
          }}
          formatter={(value: number) => [`${value}%`, 'Avg Score']}
        />
        <Bar dataKey="avgScore" fill="#22c55e" radius={[0, 4, 4, 0]} name="Avg Score" />
      </BarChart>
    </ResponsiveContainer>
  )
}
