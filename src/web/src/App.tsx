import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { LandingPage } from './routes/LandingPage';
import { LearningMap } from './routes/LearningMap';
import { QuizSession } from './routes/QuizSession';
import { QuizResult } from './routes/QuizResult';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/map" element={<LearningMap />} />
        <Route path="/quiz" element={<QuizSession />} />
        <Route path="/quiz-result" element={<QuizResult />} />
        <Route path="/exam" element={<div className="p-8 text-center">Exam Simulation - Coming Soon</div>} />
        <Route path="/mistakes" element={<div className="p-8 text-center">Mistake Garden - Coming Soon</div>} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
