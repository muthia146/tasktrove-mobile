# Tasktrove Mobile

Aplikasi Management Tugas berbasis Mobile yang dikembangkan menggunakan framework **Flutter**.

* **Nama:** Muthia Anggraeni Rukmawan
* **NPM:** 247006111029
* **Kelas:** A

## Getting Started

## Deskripsi Proyek
TaskTrove Mobile adalah aplikasi manajemen tugas yang terintegrasi langsung dengan **REST API** yang telah di-deploy di Vercel. Proyek ini mendemonstrasikan implementasi autentikasi modern, manajemen state yang reaktif, serta operasi data lengkap (CRUD).

### Fitur Utama:
- **Dashboard & Branding:** Halaman awal yang memberikan kesan visual aplikasi sebelum masuk ke sistem.
- **Autentikasi JWT:** Fitur Register dan Login yang aman dengan penyimpanan token menggunakan `flutter_secure_storage`.
- **Full CRUD Management:**
  - **Create:** Menambahkan tugas baru.
  - **Read:** Menampilkan list tugas secara real-time dari server.
  - **Update:** Mengubah deskripsi, nama matkul, atau status tugas (Pending, In Progress, Done).
  - **Delete:** Menghapus tugas dari database.
- **Three-State UI:** Implementasi kondisi *Loading*, *Error*, dan *Success* yang informatif.

## Arsitektur Aplikasi
Proyek ini menerapkan **Layered Architecture** untuk memastikan kode tetap modular dan mudah dikelola

## Cara Menjalankan Aplikasi (Panduan Lokal)
Gunakan panduan ini jika Anda ingin menjalankan proyek ini di lingkungan lokal Anda:

1. **Clone Repository:**
       git clone https://github.com/muthia146/tasktrove-mobile.git

2. **Masuk ke Direktori:**
       cd tasktrove_mobile

3. **Instalasi Dependencies:**
       flutter pub get

4. **Jalankan Aplikasi:**
   Pastikan emulator Android sudah aktif, lalu jalankan perintah:
       flutter run
