import 'package:flutter/material.dart';

class OrderAdminScreen extends StatelessWidget {
  const OrderAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifikasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Bersihkan',
                style: TextStyle(
                  color: Color(0xff4169E1),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          CardNotification()
        ],
      ),
    );
  }
}

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        height: 120,
        decoration: BoxDecoration(
            color: Color(0xffA3C5F2).withOpacity(
              0.5,
            ),
            borderRadius: BorderRadius.circular(
              16,
            )),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.done_rounded,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verifikasi alamat email berhasil',
                    style: TextStyle(
                      color: Color(0xff4169E1),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Alamat email akan digunakan untuk keamanan akun anda',
                    style: TextStyle(
                      color: Color(0xff4169E1).withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '15:23 | 24/01/2023',
                      style: TextStyle(
                        color: Color(0xff4169E1).withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
