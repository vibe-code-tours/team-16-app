import React, { useState } from 'react';

interface InterruptEvent {
  time: number;
  label: string;
}

interface InterruptTimingDiagramProps {
  interruptA: InterruptEvent[];
  interruptB: InterruptEvent[];
  maxTime?: number;
}

export function InterruptTimingDiagram({
  interruptA,
  interruptB,
  maxTime = 5,
}: InterruptTimingDiagramProps) {
  const [hoveredEvent, setHoveredEvent] = useState<string | null>(null);

  // SVG dimensions
  const width = 600;
  const height = 200;
  const padding = { top: 40, right: 40, bottom: 50, left: 80 };
  const chartWidth = width - padding.left - padding.right;
  const chartHeight = height - padding.top - padding.bottom;

  // Scale: time to x position
  const timeToX = (time: number) => padding.left + (time / maxTime) * chartWidth;

  // Y positions for the two timelines
  const yA = padding.top + chartHeight * 0.3;
  const yB = padding.top + chartHeight * 0.7;

  // Generate tick marks
  const ticks = Array.from({ length: maxTime + 1 }, (_, i) => i);

  return (
    <svg
      viewBox={`0 0 ${width} ${height}`}
      className="w-full max-w-2xl"
      role="img"
      aria-label="Interrupt timing diagram showing occurrence of interrupt A and B over time"
    >
      {/* Background */}
      <rect width={width} height={height} fill="#1e293b" rx="8" />

      {/* Title */}
      <text x={width / 2} y={20} textAnchor="middle" fill="#94a3b8" fontSize="12">
        Interrupt Timing Diagram
      </text>

      {/* Grid lines (dashed) */}
      {ticks.map((t) => (
        <line
          key={`grid-${t}`}
          x1={timeToX(t)}
          y1={padding.top - 10}
          x2={timeToX(t)}
          y2={height - padding.bottom + 10}
          stroke="#334155"
          strokeDasharray="4,4"
          strokeWidth="1"
        />
      ))}

      {/* Timeline A */}
      <line
        x1={padding.left}
        y1={yA}
        x2={timeToX(maxTime)}
        y2={yA}
        stroke="#64748b"
        strokeWidth="2"
      />
      <text x={padding.left - 10} y={yA + 4} textAnchor="end" fill="#e2e8f0" fontSize="12">
        Interrupt A
      </text>

      {/* Timeline B */}
      <line
        x1={padding.left}
        y1={yB}
        x2={timeToX(maxTime)}
        y2={yB}
        stroke="#64748b"
        strokeWidth="2"
      />
      <text x={padding.left - 10} y={yB + 4} textAnchor="end" fill="#e2e8f0" fontSize="12">
        Interrupt B
      </text>

      {/* Time axis */}
      <line
        x1={padding.left}
        y1={height - padding.bottom + 20}
        x2={timeToX(maxTime)}
        y2={height - padding.bottom + 20}
        stroke="#64748b"
        strokeWidth="1"
      />
      <text x={width / 2} y={height - 5} textAnchor="middle" fill="#94a3b8" fontSize="11">
        Time (ms)
      </text>

      {/* Tick marks and labels */}
      {ticks.map((t) => (
        <g key={`tick-${t}`}>
          <line
            x1={timeToX(t)}
            y1={height - padding.bottom + 15}
            x2={timeToX(t)}
            y2={height - padding.bottom + 25}
            stroke="#64748b"
            strokeWidth="1"
          />
          <text
            x={timeToX(t)}
            y={height - padding.bottom + 38}
            textAnchor="middle"
            fill="#94a3b8"
            fontSize="11"
          >
            {t}
          </text>
        </g>
      ))}

      {/* Interrupt A events */}
      {interruptA.map((event, i) => {
        const x = timeToX(event.time);
        const eventId = `a-${i}`;
        const isHovered = hoveredEvent === eventId;

        return (
          <g
            key={eventId}
            onMouseEnter={() => setHoveredEvent(eventId)}
            onMouseLeave={() => setHoveredEvent(null)}
            className="cursor-pointer"
          >
            {/* Arrow line */}
            <line
              x1={x}
              y1={yA - 25}
              x2={x}
              y2={yA - 5}
              stroke={isHovered ? '#3b82f6' : '#22c55e'}
              strokeWidth={isHovered ? 3 : 2}
            />
            {/* Arrow head */}
            <polygon
              points={`${x},${yA - 3} ${x - 5},${yA - 12} ${x + 5},${yA - 12}`}
              fill={isHovered ? '#3b82f6' : '#22c55e'}
            />
            {/* Tooltip */}
            {isHovered && (
              <g>
                <rect
                  x={x - 40}
                  y={yA - 55}
                  width={80}
                  height={24}
                  fill="#0f172a"
                  stroke="#3b82f6"
                  rx="4"
                />
                <text
                  x={x}
                  y={yA - 39}
                  textAnchor="middle"
                  fill="#e2e8f0"
                  fontSize="11"
                >
                  {event.label} @ {event.time}ms
                </text>
              </g>
            )}
          </g>
        );
      })}

      {/* Interrupt B events */}
      {interruptB.map((event, i) => {
        const x = timeToX(event.time);
        const eventId = `b-${i}`;
        const isHovered = hoveredEvent === eventId;

        return (
          <g
            key={eventId}
            onMouseEnter={() => setHoveredEvent(eventId)}
            onMouseLeave={() => setHoveredEvent(null)}
            className="cursor-pointer"
          >
            {/* Arrow line */}
            <line
              x1={x}
              y1={yB - 25}
              x2={x}
              y2={yB - 5}
              stroke={isHovered ? '#3b82f6' : '#ef4444'}
              strokeWidth={isHovered ? 3 : 2}
            />
            {/* Arrow head */}
            <polygon
              points={`${x},${yB - 3} ${x - 5},${yB - 12} ${x + 5},${yB - 12}`}
              fill={isHovered ? '#3b82f6' : '#ef4444'}
            />
            {/* Tooltip */}
            {isHovered && (
              <g>
                <rect
                  x={x - 40}
                  y={yB - 55}
                  width={80}
                  height={24}
                  fill="#0f172a"
                  stroke="#3b82f6"
                  rx="4"
                />
                <text
                  x={x}
                  y={yB - 39}
                  textAnchor="middle"
                  fill="#e2e8f0"
                  fontSize="11"
                >
                  {event.label} @ {event.time}ms
                </text>
              </g>
            )}
          </g>
        );
      })}
    </svg>
  );
}

// Example usage with the diagram from the image
export function ExampleInterruptDiagram() {
  const interruptA: InterruptEvent[] = [
    { time: 1, label: 'A1' },
    { time: 3, label: 'A2' },
    { time: 4, label: 'A3' },
  ];

  const interruptB: InterruptEvent[] = [
    { time: 0, label: 'B1' },
    { time: 5, label: 'B2' },
  ];

  return (
    <div className="p-4">
      <InterruptTimingDiagram
        interruptA={interruptA}
        interruptB={interruptB}
        maxTime={5}
      />
    </div>
  );
}
