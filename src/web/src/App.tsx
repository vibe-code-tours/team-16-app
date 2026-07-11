import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { AuthProvider } from './hooks/useAuth.tsx'
import { ProtectedRoute } from './components/ProtectedRoute'
import { LandingPage } from './routes/LandingPage'
import { LoginPage } from './routes/LoginPage'
import { RegisterPage } from './routes/RegisterPage'
import { LearningMap } from './routes/LearningMap'
import { QuizSession } from './routes/QuizSession'
import { QuizResult } from './routes/QuizResult'

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          {/* Public routes */}
          <Route path="/" element={<LandingPage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />

          {/* Protected routes */}
          <Route
            path="/map"
            element={
              <ProtectedRoute>
                <LearningMap />
              </ProtectedRoute>
            }
          />
          <Route
            path="/quiz/:topicId"
            element={
              <ProtectedRoute>
                <QuizSession />
              </ProtectedRoute>
            }
          />
          <Route
            path="/quiz-result"
            element={
              <ProtectedRoute>
                <QuizResult />
              </ProtectedRoute>
            }
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  )
}
