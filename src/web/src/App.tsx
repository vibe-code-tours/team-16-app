import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { AuthProvider } from './hooks/useAuth.tsx'
import { ProtectedRoute } from './components/ProtectedRoute'
import { LandingPage } from './routes/LandingPage'
import { LoginPage } from './routes/LoginPage'
import { RegisterPage } from './routes/RegisterPage'
import { LearningMap } from './routes/LearningMap'
import { TopicDetail } from './routes/TopicDetail'
import { LessonPage } from './routes/LessonPage'
import { QuizPage } from './routes/QuizPage'

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
            path="/topic/:topicId"
            element={
              <ProtectedRoute>
                <TopicDetail />
              </ProtectedRoute>
            }
          />
          <Route
            path="/lesson/:lessonId"
            element={
              <ProtectedRoute>
                <LessonPage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/quiz/:quizId"
            element={
              <ProtectedRoute>
                <QuizPage />
              </ProtectedRoute>
            }
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  )
}
