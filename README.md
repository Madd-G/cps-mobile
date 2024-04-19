# cps_mobile

CPS mobile merupakan sebuah aplikasi resource data user di Accurate. Pada aplikasi ini pengguna dapat melihat daftar user, detail info user, menghapus user, melakukan pencarian, melakukan sorting, filtering berdasarkan kota baik secara online maupun offline.

## Beberapa fitur kunci pada aplikasi ini:
* Melihat daftar user 
* Melakukan pencarian user berdasarkan nama
* Mengurutkan user berdasarkan nama
* Memfilter user berdasarkan kota
* Menambahkan user baru
* Menghapus user

Fitur fitur ini dapat digunakan baik secara online maupun offline.

## Goals yang diselesaikan
* Berjalan baik di iOS dan Android.
* User experience yang baik dan mudah digunakan saat melihat daftar user, mencari user, filter user dan menambahkan user baru.

## Cara penggunaan
ketika user pertama kali membuka aplikasi, user akan melihat daftar user yang tersedia. Jika user ingin melihat berdasarkan kota, maka user dapat menekan dropdown yang tersedia dan dropdown akan menampilkan daftar kota yang tersedia. User juga dapat melakukan sorting atau mengurutkan user berdasarkan abjad huruf baik secara ascending maupun descending. User juga dapat mencari user melalui text pencarian yang tersedia. Untuk menambahkan user, pengguna dapat menekan floating action button di bagian kanan bawah, maka akan menampilkan modal bottom sheet yang berisi form untuk mengisi data user. User dapat melihat detail user dengan cara menekan nama user yang tersedia pada list. Pada detail info, user dapat menghapus user.

## Teknologi dan dependency yang digunakan
* Dart
* Flutter
* Http
* BLoC
* SQLite
* Get (GetX)
* Get_it
* Equatable
* RxDart
* Dartz
* Lottie
* Shimmer

## Penjelasan tampilan dan interaksi
Aplikasi ini menerapkan konsep minimalis dan effisien. Jadi ketika menggunakan aplikasi ini, user dapat mengakses seluruh fitur hanya dengan sekali tap, maksudnya seluruh fitur langsung ditampilkan di layar depan sehingga user tidak perlu bingung mencari atau menemukan tiap fitur. Aplikasi juga dilengkapi animasi sehingga tetap menarik untuk dilihat. Terdapat juga penjelasan - penjelasan yang dapat membantu user seperti misalnya text untuk menunjukkan berapa jumlah user yang tersedia, snackbar yang muncul ketika user menambahkan atau menghapus user.

## Nice to have
* Implementasi SOLID principle.
* Implementasi Clean Architecture (Data, Domain, Presentation).
* Implementasi BLoC sebagai state management.
* Implementasi GetX sebagai navigasi.
* Implementasi Get_it sebagai dependency injection.

## Here are the steps to run the application:

1. **Clone the Repository:**
    ```bash
    git clone git@github.com:Madd-G/cps-mobile.git
    cd movie-app-test
    ```

2. **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the Application:**
    ```bash
    flutter run
    ```

