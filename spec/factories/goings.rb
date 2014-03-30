FactoryGirl.define do
  factory :going do
    start_location "-10.2107698,-48.343343800000014"
    end_location "-10.2107698,-48.343343800000014"
    waypoints "[[-10.2107698,-48.343343800000014]]"
    blocks_passed "103 N NS 02, 104 S NS 06, 105 S NS 03"
    schedule "13:10,20:30,11:20"
    downvotes 0
    line_id 1
    surroundings "203 N, 304 S, 405 S"
    days_of_week "Seg,Qua,Sex"
    frequency 15
  end
end