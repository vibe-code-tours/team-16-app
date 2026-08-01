import { Suspense, lazy } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "./hooks/useAuth.tsx";
import { ProtectedRoute } from "./components/ProtectedRoute";
import { AdminRoute } from "./components/AdminRoute";
import { StudentRoute } from "./components/StudentRoute";
import { Layout } from "./components/layout";

const LandingPage = lazy(() => import("./routes/LandingPage").then(m => ({ default: m.LandingPage })));
const LoginPage = lazy(() => import("./routes/LoginPage").then(m => ({ default: m.LoginPage })));
const RegisterPage = lazy(() => import("./routes/RegisterPage").then(m => ({ default: m.RegisterPage })));
const LearningMap = lazy(() => import("./routes/LearningMap").then(m => ({ default: m.LearningMap })));
const TopicDetail = lazy(() => import("./routes/TopicDetail").then(m => ({ default: m.TopicDetail })));
const LessonPage = lazy(() => import("./routes/LessonPage").then(m => ({ default: m.LessonPage })));
const QuizPage = lazy(() => import("./routes/QuizPage").then(m => ({ default: m.QuizPage })));
const MistakeGarden = lazy(() => import("./routes/MistakeGarden").then(m => ({ default: m.MistakeGarden })));
const UserProfile = lazy(() => import("./routes/UserProfile").then(m => ({ default: m.UserProfile })));
const ExamSimulation = lazy(() => import("./routes/ExamSimulation"));
const QuizListingPage = lazy(() => import("./routes/QuizListingPage").then(m => ({ default: m.QuizListingPage })));
const AiDraftPreview = lazy(() => import("./routes/AiDraftPreview").then(m => ({ default: m.AiDraftPreview })));
const AdminDashboard = lazy(() => import("./routes/AdminDashboard").then(m => ({ default: m.AdminDashboard })));
const AdminUsers = lazy(() => import("./routes/AdminUsers").then(m => ({ default: m.AdminUsers })));
const WeakPointAnalysis = lazy(() => import("./routes/WeakPointAnalysis").then(m => ({ default: m.WeakPointAnalysis })));
const QuizResult = lazy(() => import("./routes/QuizResult").then(m => ({ default: m.QuizResult })));

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Suspense fallback={<div className="flex min-h-[50vh] items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" /></div>}>
        <Routes>
          {/* Public routes - no header, no sidebar */}
          <Route path="/" element={<Layout showSidebar={false} showHeader={false}><LandingPage /></Layout>} />
          <Route path="/login" element={<Layout showSidebar={false} showHeader={false}><LoginPage /></Layout>} />
          <Route path="/register" element={<Layout showSidebar={false} showHeader={false}><RegisterPage /></Layout>} />
          <Route
            path="/ai-draft"
            element={
              <ProtectedRoute>
                <AdminRoute>
                  <Layout showSidebar={false}>
                    <AiDraftPreview />
                  </Layout>
                </AdminRoute>
              </ProtectedRoute>
            }
          />

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
            path="/quizzes"
            element={
              <ProtectedRoute>
                <Layout>
                  <QuizListingPage />
                </Layout>
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
            path="/quiz-result/:sessionId?"
            element={
              <ProtectedRoute>
                <StudentRoute>
                  <Layout>
                    <QuizResult />
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
                  <ExamSimulation />
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
          <Route
            path="/weak-points"
            element={
              <ProtectedRoute>
                <Layout>
                  <WeakPointAnalysis />
                </Layout>
              </ProtectedRoute>
            }
          />
        </Routes>
        </Suspense>
      </AuthProvider>
    </BrowserRouter>
  );
}
