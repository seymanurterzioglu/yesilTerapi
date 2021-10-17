import 'package:flutter/material.dart';

import '../size_config.dart';
import 'complete_profile_form.dart';

class CompleteProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Column(
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Profili Tamamlayalım",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(32),
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(7)),
              Text(
                "Aşağıdaki bilgileri güncel doldurursanız, size daha \niyi yardımcı olabiliriz.",
                textAlign: TextAlign.center,
              ),
              CompleteProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
