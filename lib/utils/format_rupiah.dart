import 'package:intl/intl.dart';

String formatRupiah(int value) {
  final formatter = NumberFormat('#,###', 'id_ID');
  return 'Rp. ${formatter.format(value)}';
}
