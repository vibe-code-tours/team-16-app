import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "./hooks/useAuth.tsx";
import { ProtectedRoute } from "./components/ProtectedRoute";
import { AdminRoute } from "./components/AdminRoute";
import { StudentRoute } from "./components/StudentRoute";
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
import { AdminDashboard } from "./routes/AdminDashboard";
import { AdminUsers } from "./routes/AdminUsers";

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          {/* Public routes - no header, no sidebar */}
          <Route path="/" element={<Layout showSidebar={false} showHeader={false}><LandingPage /></Layout>} />
          <Route path="/login" element={<Layout showSidebar={false} showHeader={false}><LoginPage /></Layout>} />
          <Route path="/register" element={<Layout showSidebar={false} showHeader={false}><RegisterPage /></Layout>} />
          <Route path="/ai-draft" element={<Layout showSidebar={false}><AiDraftPreview /></Layout>} />

          {/* Protected routes - with layout */}
          <Route
            path="/map"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <LearningMap />
                  </Layout>
                </StudentRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/map/:topicId"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <TopicDetail />
                  </Layout>
                </StudentRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/lesson/:lessonId"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <LessonPage />
                  </Layout>
                </StudentRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/quiz/:subtopicId"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <QuizPage />
                  </Layout>
                </StudentRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/mistakes"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <MistakeGarden />
                  </Layout>
                </StudentRoute>
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
                <StudentRoute>
                  <Layout>
                    <ExamPage />
                  </Layout>
                </StudentRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin"
            element={
              <ProtectedRoute>
                <AdminRoute>
                  <Layout>
                    <AdminDashboard />
                  </Layout>
                </AdminRoute>
              </ProtectedRoute>
            }
          />
          <Route
            path="/admin/users"
            element={
              <ProtectedRoute>
                <AdminRoute>
                  <Layout>
                    <AdminUsers />
                  </Layout>
                </AdminRoute>
              </ProtectedRoute>
            }
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}
