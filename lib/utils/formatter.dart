import 'package:intl/intl.dart';

String formatRupiah(int value) {
  final formatter = NumberFormat('#,###', 'id_ID');
  return 'Rp. ${formatter.format(value)}';
}

String formatWaktu(DateTime waktu) {
  final formatter = DateFormat('dd-MM-yyyy');
  return '${formatter.format(waktu)}';
}
