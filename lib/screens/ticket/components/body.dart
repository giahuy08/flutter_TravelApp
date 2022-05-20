import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final dynamic booktour;
  const Body({Key? key, required this.booktour}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        title: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'THÔNG TIN VÉ ĐÃ ĐẶT',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      oCcy.format(widget.booktour.finalpayment) + " VNĐ",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                margin: const EdgeInsets.fromLTRB(26, 26, 26, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(logo),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          widget.booktour.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Từ',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text('Trường ĐH SPKT'),
                                const SizedBox(height: 14),
                                const Text(
                                  'Đến',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(widget.booktour.place),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ngày khởi hành',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(widget.booktour.startDate!)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8)),
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  'Ngày kết thúc',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(widget.booktour.endDate!)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: kDarkColor,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Khách hàng',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.booktour.nameUser,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Số điện thoại',
                                  style: TextStyle(
                                      color: kDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.booktour.phoneUser,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: kDarkColor,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          (widget.booktour.idUser + widget.booktour.idTour),
                          style: const TextStyle(
                              fontFamily: 'Barcode',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ID: ' + widget.booktour.id,
                style: const TextStyle(
                  color: kLightColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
