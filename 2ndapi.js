for (Sensitivity sensitivity : sensitivities) {
                if (sensitivity.getBdrid() != null) {
                    String bdrid = sensitivity.getBdrid();
                    if (bdrid.length() < 10) {
                        // Pad with leading zeros to make it 10 digits
                        bdrid = String.format("%010d", Long.parseLong(bdrid));
                        sensitivity.setBdrid(bdrid);
                    }
                }
            }
