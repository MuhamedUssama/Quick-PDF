# Smart Document Scanner & Arabic OCR App

## 1. Executive Summary
An intuitive, multi-group mobile application built with **Flutter** for **Android & iOS**, tailored for high-efficiency document capturing and Arabic handwritten text extraction. The app allows users to conduct continuous scanning sessions, organize captured pages into custom-named groups on the fly, extract handwritten Arabic text using AI, and compile each group into professionally formatted PDF documents seamlessly.

---

## 2. Core Problem & Solution
* **The Problem:** Extracting handwritten Arabic text from physical papers (e.g., study notes, lectures) is notoriously difficult with standard local OCR tools. Furthermore, conventional scanner apps force users to process one document at a time, disrupting the scanning flow when handling multiple distinct topics in a single session.
* **The Solution:** A specialized scanner application leveraging Cloud-based multimodal AI (**Firebase AI Edge / Gemini**) for superior Arabic handwriting recognition, paired with a non-intrusive batch-scanning user flow that group-tags images during capture and defers heavy processing/PDF generation to the end of the session.

---

## 3. Detailed User Flow & Journey

### Phase 1: Session & Group Initialization
1. User taps **"Start New Session"** from the Dashboard.
2. A fast-input modal prompts the user to enter the **First Group Name** (e.g., *"Lecture 1"*).
3. The app immediately opens the camera interface without further friction.

### Phase 2: Batch Camera Scanning (Continuous Capture)
1. User captures photos for the active group.
2. An overlay UI displays the current active group name and image count (e.g., *"Current: Lecture 1 (3 images)"*).
3. When done with the first topic, the user taps **"New Group"**.
4. A quick dialog appears to name the next group (e.g., *"Lecture 2"*). The camera preview **remains open**, the internal counter resets to 0, and captures continue under the new group tag.
5. Once all target groups are shot (e.g., 20 photos across 5 distinct groups), the user taps **"Finish Session"**.

### Phase 3: Review & Local Verification
1. User is presented with a structured summary screen listing all groups and their thumbnails.
2. Options to delete blurry shots, reorder images, or rename groups.
3. User confirms by clicking **"Extract Text & Generate PDFs"**.

### Phase 4: AI Processing & PDF Compilation
1. Images are processed through Firebase AI Edge (Gemini 1.5 Flash) to extract Arabic handwritten text.
2. Extracted text is fed into a styled PDF engine with embedded Arabic fonts (RTL layout support).
3. Final PDFs are generated per group and saved to local storage with native sharing capabilities.

---

## 4. Technical Architecture & Tech Stack

### Architecture Pattern
* **Clean Architecture + Feature-First Approach**
* Separation into 3 primary layers per feature: `Data`, `Domain`, and `Presentation`.

### Technology Stack
* **Framework:** Flutter (Dart)
* **State Management:** `flutter_bloc` / `Cubit`
* **Local Storage:** `hive_ce` & `hive_ce_flutter` + `path_provider`
* **Camera System:** `camerawesome`
* **AI & OCR Services:** `firebase_ai_edge` (Gemini 1.5 Flash model)
* **PDF Engine:** `pdf` & `printing`

---

## 5. Development Roadmap (Phased Breakdown)

### Part 1: Core Foundation & Data Layer Setup (Current Focus)
* Configure project guidelines and Clean Architecture folder structure.
* Setup `hive_ce` models (`GroupModel`, `ImageModel`) and local datasources for offline session caching.
* Setup `firebase_ai_edge` remote datasource for image-to-text Arabic handwritten extraction.
* Establish Repository interfaces and contracts in the Domain layer.

### Part 2: Camera & Multi-Group Capture UI
* Implement `camerawesome` integration.
* Build the active session overlay (counter, group switching, state management with Cubit).
* Wire camera captures to persist directly into local Hive storage.

### Part 3: Review, AI Extraction & PDF Engine
* Implement the Review & Management screen.
* Integrate async processing pipeline (Sending images to Gemini API in sequence/parallel).
* Build the PDF generation service with Arabic font binding (e.g., Cairo/Amiri font) and RTL alignment.

### Part 4: Preview, Management & Polish
* Implement document preview and sharing via `printing` package.
* Build the Dashboard history page to view past PDF projects.
* Error handling, loading indicators, and edge-case handling.