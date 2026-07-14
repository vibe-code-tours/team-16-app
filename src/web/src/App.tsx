import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "./hooks/useAuth.tsx";
import { ProtectedRoute } from "./components/ProtectedRoute";
import { Layout } from "./components/layout";
import { LandingPage } from "./routes/LandingPage";
import { LoginPage } from "./routes/LoginPage";
import { RegisterPage } from "./routes/RegisterPage";
import { LearningMap } from "./routes/LearningMap";
import { TopicDetail } from "./routes/TopicDetail";
import { LessonPage } from "./routes/LessonPage";
import { QuizPage } from "./routes/QuizPage";
import { MistakeGarden } from "./routes/MistakeGarden";
import { UserProfile } from "./routes/UserProfile";
import { ExamPage } from "./routes/ExamPage";
import { AiDraftPreview } from "./routes/AiDraftPreview";

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          {/* Public routes - no layout */}
          <Route path="/" element={<LandingPage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/register" element={<RegisterPage />} />
          <Route path="/ai-draft" element={<AiDraftPreview />} />

          {/* Protected routes - with layout */}
          <Route
            path="/map"
            element={
              <ProtectedRoute>
                <Layout>
                  <LearningMap />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/map/:topicId"
            element={
              <ProtectedRoute>
                <Layout>
                  <TopicDetail />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/lesson/:lessonId"
            element={
              <ProtectedRoute>
                <Layout>
                  <LessonPage />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/quiz/:subtopicId"
            element={
              <ProtectedRoute>
                <Layout>
                  <QuizPage />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/mistakes"
            element={
              <ProtectedRoute>
                <Layout>
                  <MistakeGarden />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/profile"
            element={
              <ProtectedRoute>
                <Layout>
                  <UserProfile />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/exam"
            element={
              <ProtectedRoute>
                <Layout showSidebar={false}>
                  <ExamPage />
                </Layout>
              </ProtectedRoute>
            }
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}
