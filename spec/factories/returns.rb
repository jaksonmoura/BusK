FactoryGirl.define do
  factory :return do
    start_location "-10.2107698,-48.343343800000014"
    end_location "-10.2107698,-48.343343800000014"
    waypoints "[[-10.2107698,-48.343343800000014]]"
    blocks_passed "203 N NS 02, 304 S NS 06, 405 S NS 03"
    schedule "13:10,20:30,11:20"
    downvotes 0
    line_id 1
    surroundings "103 N, 303 N, 205 N, 104 S, 105 S"
    days_of_week "Seg,Qua,Sex"
    frequency 15
  end
end