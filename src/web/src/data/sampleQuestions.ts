import type { Question } from '../types/Quiz';

// Sample questions for demo (will come from API later)
export const SAMPLE_QUESTIONS: Question[] = [
  {
    id: '12',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 12,
    topic_category: 'System Architecture',
    difficulty: 'medium',
    question_text:
      'One (1) server, three (3) clients, and two (2) printers are connected via a LAN as shown in the figure below. This system prints data that is located on the server in response to instructions from the clients. When the availability of each device is as shown in the table below, which of the following is the expression that represents the availability for the system? Here, the system is considered available if one (1) of the three (3) clients and one (1) of the two (2) printers are running.',
    content_blocks: [
      {
        type: 'text',
        text: '**Network Topology:** Bus network with the following devices:',
      },
      {
        type: 'markdown',
        text: '| Device | Availability |\n|--------|--------------|\n| Server | a |\n| Client | b |\n| Printer | c |\n| LAN | 1 |',
      },
      {
        type: 'text',
        text: '**System Availability Condition:** The system is available if:\n- The server is available AND\n- At least one of the three clients is available AND\n- At least one of the two printers is available',
      },
    ],
    choices: [
      { label: 'a', text: 'ab³c²' },
      { label: 'b', text: 'a(1-b³)(1-c²)' },
      { label: 'c', text: 'a(1-b)³(1-c)²' },
      { label: 'd', text: 'a(1-(1-b)³)(1-(1-c)²)' },
    ],
    correct_answer: 'd',
    explanation:
      'The correct answer is **d) a(1-(1-b)³)(1-(1-c)²)**.\n\n**Explanation:**\n\n1. **Server availability:** The server must be available → factor of `a`\n\n2. **Client availability:** At least one of 3 clients must work. The probability that ALL clients fail is (1-b)³, so the probability that at least one works is:\n   `1 - (1-b)³`\n\n3. **Printer availability:** At least one of 2 printers must work. The probability that ALL printers fail is (1-c)², so the probability that at least one works is:\n   `1 - (1-c)²`\n\n4. **System availability:** All components are independent, so multiply:\n   `a × (1-(1-b)³) × (1-(1-c)²)`\n\nThis matches option **d**.',
  },
  {
    id: '1',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 10,
    topic_category: 'Technology',
    difficulty: 'easy',
    question_text:
      'Which of the following is an appropriate description of a 3D printer\'s function?',
    choices: [
      {
        label: 'a',
        text: 'It detects the shape of three-dimensional objects and produces output of 3D data.',
      },
      {
        label: 'b',
        text: 'It functions by pushing the pins of a high-temperature printing head onto heat-sensitive paper.',
      },
      {
        label: 'c',
        text: 'It makes three-dimensional objects using methods such as fused filament fabrication.',
      },
      {
        label: 'd',
        text: 'It projects computer graphics onto uneven three-dimensional objects such as buildings and furniture.',
      },
    ],
    correct_answer: 'c',
    explanation:
      'A 3D printer creates physical three-dimensional objects from digital models. Fused Filament Fabrication (FFF) is one of the most common 3D printing technologies where material is extruded layer by layer.',
  },
  {
    id: '2',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 11,
    topic_category: 'Technology',
    difficulty: 'easy',
    question_text:
      'Which of the following is the most appropriate explanation of edge computing?',
    choices: [
      {
        label: 'a',
        text: 'Increasing the operability and expressiveness of web application software by performing screen creation and data processing on the client side',
      },
      {
        label: 'b',
        text: 'Increasing the real-time nature of processing by performing primary processing of data on a server or other such computer in a location close to the origin of data, such as a sensor that is attached to a user or a device',
      },
      {
        label: 'c',
        text: 'Increasing throughput with parallel processing by virtualizing and integrating several servers and PCs and creating a single high-performance computer',
      },
      {
        label: 'd',
        text: 'Starting up the required server only when data comes in, and freeing up resources by stopping the server as soon as the processing is finished',
      },
    ],
    correct_answer: 'b',
    explanation:
      'Edge computing processes data near the source (edge of the network) rather than sending it to a centralized cloud. This reduces latency and enables real-time processing for IoT devices and sensors.',
  },
  {
    id: '3',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 17,
    topic_category: 'Technology',
    difficulty: 'easy',
    question_text:
      'Which of the following is a method used to improve the appearance of a jagged edge of a slanted line so that it appears smooth on a screen, such as that of an LCD?',
    choices: [
      { label: 'a', text: 'Anti-aliasing' },
      { label: 'b', text: 'Bump mapping' },
      { label: 'c', text: 'Shading' },
      { label: 'd', text: 'Texture mapping' },
    ],
    correct_answer: 'a',
    explanation:
      'Anti-aliasing is a technique used to smooth the jagged edges (aliasing) of rendered lines and shapes by blending the colors of the edge pixels with the background.',
  },
  {
    id: '4',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 42,
    topic_category: 'Management',
    difficulty: 'hard',
    question_text:
      'Based on the requirements gathered, the cost of a software project under normal conditions is estimated at $70,000. In case of smooth project implementation, some activities are not required and the estimated cost is reduced to $50,000; however, in the worst-case scenario, additional tasks are required and the cost increases to $120,000. What is the expected cost of the project (in dollars) that is calculated by using the three-point estimate in the beta distribution, also known as PERT?',
    choices: [
      { label: 'a', text: '70,000' },
      { label: 'b', text: '75,000' },
      { label: 'c', text: '80,000' },
      { label: 'd', text: '85,000' },
    ],
    correct_answer: 'c',
    explanation:
      'PERT formula: Expected = (Optimistic + 4×Most Likely + Pessimistic) / 6\nExpected = (50,000 + 4×70,000 + 120,000) / 6 = (50,000 + 280,000 + 120,000) / 6 = 450,000 / 6 = 75,000',
  },
  {
    id: '5',
    exam_session: '2025-october',
    subject: 'A',
    question_number: 47,
    topic_category: 'Strategy',
    difficulty: 'easy',
    question_text:
      'Which of the following is a measure for the risk of a decline in the system maintenance and operation quality during the outsourcing of an IT service?',
    choices: [
      {
        label: 'a',
        text: 'Clearly stating the detailed fee structure by service in the contract or other documents, in order to validate the service costs',
      },
      {
        label: 'b',
        text: 'Requesting a proposal for the human resource development plan of the company after outsourcing during the stage of subcontractor selection, and clearly stating it in the contract or other documents',
      },
      {
        label: 'c',
        text: 'Securing human resources with capabilities to evaluate the appropriateness of service costs for system maintenance and operation within the company',
      },
      {
        label: 'd',
        text: 'Using indexes that demonstrate the service quality in order to promote improvement activities after agreeing on the desired level of quality with the subcontractor',
      },
    ],
    correct_answer: 'd',
    explanation:
      'Using quality indexes (KPIs) and agreeing on service level targets helps monitor and maintain quality after outsourcing. This provides measurable standards for evaluation and improvement.',
  },
];
