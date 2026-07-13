import React from 'react';
import {
  InterruptTimingDiagram,
  ExampleInterruptDiagram,
} from '../components/features/InterruptTimingDiagram';

export function InterruptDiagramPreview() {
  return (
    <div className="min-h-screen bg-slate-900 p-8">
      <div className="max-w-4xl mx-auto space-y-8">
        <h1 className="text-3xl font-bold text-white text-center">
          Interrupt Timing Diagram
        </h1>
        <p className="text-slate-400 text-center">
          Interactive SVG component for displaying interrupt timing diagrams
        </p>

        {/* Example from the original image */}
        <section className="bg-slate-800 rounded-lg p-6 border border-slate-700">
          <h2 className="text-xl font-semibold text-white mb-4">
            Example: ITPEC FE Exam Question
          </h2>
          <ExampleInterruptDiagram />
        </section>

        {/* Custom example */}
        <section className="bg-slate-800 rounded-lg p-6 border border-slate-700">
          <h2 className="text-xl font-semibold text-white mb-4">
            Custom Diagram
          </h2>
          <InterruptTimingDiagram
            interruptA={[
              { time: 0.5, label: 'A1' },
              { time: 1.5, label: 'A2' },
              { time: 2.5, label: 'A3' },
              { time: 3.5, label: 'A4' },
              { time: 4.5, label: 'A5' },
            ]}
            interruptB={[
              { time: 1, label: 'B1' },
              { time: 3, label: 'B2' },
            ]}
            maxTime={5}
          />
        </section>

        {/* API Documentation */}
        <section className="bg-slate-800 rounded-lg p-6 border border-slate-700">
          <h2 className="text-xl font-semibold text-white mb-4">API</h2>
          <pre className="bg-slate-900 p-4 rounded text-slate-300 text-sm overflow-x-auto">
{`interface InterruptEvent {
  time: number;  // Time in ms
  label: string; // Label for the event
}

<InterruptTimingDiagram
  interruptA={InterruptEvent[]}
  interruptB={InterruptEvent[]}
  maxTime={number}  // Default: 5
/>`}
          </pre>
        </section>
      </div>
    </div>
  );
}
