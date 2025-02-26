
# Redis Cluster

Proyek ini dirancang untuk mengatur konfigurasi klaster Redis dengan menggunakan beberapa node. Berikut adalah penjelasan mengenai isi dari folder dan file yang terdapat dalam proyek ini.

## Isi Folder

```
redis-cluster
├── create_cluster.sh
├── data
│   ├── redis1
│   │   ├── appendonly.aof
│   │   ├── dump.rdb
│   │   └── nodes.conf
│   ├── redis2
│   │   ├── appendonly.aof
│   │   ├── dump.rdb
│   │   └── nodes.conf
│   ├── redis3
│   │   ├── appendonly.aof
│   │   ├── dump.rdb
│   │   └── nodes.conf
│   ├── redis4
│   │   ├── appendonly.aof
│   │   ├── dump.rdb
│   │   └── nodes.conf
│   ├── redis5
│   │   ├── appendonly.aof
│   │   ├── dump.rdb
│   │   └── nodes.conf
│   └── redis6
│       ├── appendonly.aof
│       ├── dump.rdb
│       └── nodes.conf
├── docker-compose.yaml
├── nodes-1.conf
├── nodes-2.conf
└── nodes-3.conf
```

### Deskripsi File dan Folder

- `create_cluster.sh`: Skrip shell ini digunakan untuk membuat klaster Redis dengan otomatis. Skrip ini akan mengatur dan menginisialisasi node-node Redis.

- `data`: Folder ini berisi sub-folder untuk setiap node Redis (redis1 hingga redis6). Setiap sub-folder berisi file data untuk masing-masing node:
  - `appendonly.aof`: File AOF (Append Only File) untuk penyimpanan log perubahan yang diterapkan pada database Redis.
  - `dump.rdb`: File basis data snapshot dari kondisi terbaru.
  - `nodes.conf`: Konfigurasi node untuk mengatur komunikasi dan alokasi dalam klaster.

- `docker-compose.yaml`: File YAML ini digunakan oleh Docker Compose untuk mengatur layanan-layanan yang diperlukan untuk menjalankan klaster Redis.

- `nodes-1.conf`, `nodes-2.conf`, `nodes-3.conf`: File-file ini berisi konfigurasi tambahan untuk masing-masing node Redis. 

## Cara Menggunakan

1. Pastikan semua dependensi yang diperlukan sudah terpasang, termasuk Docker dan Docker Compose.
2. Jalankan skrip `create_cluster.sh` untuk memulai dan mengkonfigurasi klaster.
3. Gunakan `docker-compose` untuk memulai atau menghentikan klaster sesuai kebutuhan.

## Menggunakan `redis-cli -c`

Setelah klaster berjalan, Anda dapat menggunakan `redis-cli` dengan opsi `-c` untuk berinteraksi dengan klaster Redis. Contoh perintah:

```bash
redis-cli -c -h <node-ip> -p <node-port>
```

### Contoh PUT dan GET

Berikut adalah contoh cara memasukkan (PUT) dan mendapatkan (GET) data dari klaster Redis pada beberapa node berbeda:

1. **Set key di Node 1:**

   ```bash
   redis-cli -c -h <node1-ip> -p <node1-port> set mykey1 "Hello from Node 1"
   ```

2. **Dapatkan key dari Node 2:**

   ```bash
   redis-cli -c -h <node2-ip> -p <node2-port> get mykey1
   ```

3. **Set key di Node 3:**

   ```bash
   redis-cli -c -h <node3-ip> -p <node3-port> set mykey2 "Hello from Node 3"
   ```

4. **Dapatkan key dari Node 4:**

   ```bash
   redis-cli -c -h <node4-ip> -p <node4-port> get mykey2
   ```

Gantilah `<node-ip>` dan `<node-port>` dengan alamat IP dan port yang sesuai dari node-node yang membentuk klaster Anda.

