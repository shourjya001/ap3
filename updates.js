for (ResponseInternalRatingsEvent wrapper : responseObjects) {
                if (wrapper.getRelationships() != null) {
                    // BDRID Padding Logic
                    for (Relationships relationship : wrapper.getRelationships()) {
                        // Check and pad BDRID if needed
                        if (relationship.getBdrid() != null) {
                            String bdrid = relationship.getBdrid();
                            if (bdrid.length() < 10) {
                                // Pad with leading zeros to make it 10 digits
                                bdrid = String.format("%010d", Long.parseLong(bdrid));
                                relationship.setBdrid(bdrid);
                            }
                        }
                    }
                    
                    allRelationships.addAll(wrapper.getRelationships());
                }
 }
