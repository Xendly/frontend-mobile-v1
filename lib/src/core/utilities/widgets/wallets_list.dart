import 'package:flutter/material.dart';

import '../interfaces/colors.dart';

class WalletsList extends StatefulWidget {
  final int? itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  const WalletsList({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<WalletsList> createState() => _WalletsListState();
}

class _WalletsListState extends State<WalletsList> {
  late String selectedWallet;
  @override
  void initState() {
    super.initState();
    selectedWallet = "NGN";
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(4, 32, 4, 22),
          color: XMColors.shade6,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 6,
                width: 64,
                decoration: BoxDecoration(
                  color: XMColors.shade4,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 26),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: widget.itemCount!,
                itemBuilder: widget.itemBuilder,
              ),
            ],
          ),
        )
      ],
    );
  }
}
