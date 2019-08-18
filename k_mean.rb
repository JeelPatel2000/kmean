require 'gosu'

OFF_X = 200
OFF_Y = 400
#new commnet added
# new cmt
class DataPoint 
    attr_accessor :x, :y, :group
    def initialize(x1,x2,y1,y2)
        @group = 0
        @x = rand(x1..x2)
        @y = rand(y1..y2)
    end
end

class KMean < Gosu::Window
    attr_accessor :dataset, :k, :total_data_points, :means, :colors
    def initialize 
        super 1000,800
        self.caption = "K Mean Clustring"
        @colors = Array.new()
        @colors << Gosu::Color.argb(0xff_00ff00)
        @colors << Gosu::Color.argb(0xff_ff0000)
        @colors << Gosu::Color.argb(0xff_ffff00)
        @colors << Gosu::Color.argb(0xff_00ffff)

        @total_data_points = 50  # total number of data points 
        
        @dataset = Array.new()   # creating an array of dataset 
        
        @total_data_points.times do |i|      # generating random data points
            @dataset << DataPoint.new(1,30,1,30)
        end

        @total_data_points.times do |i|      # generating random data points
            @dataset << DataPoint.new(40,80,10,30)
        end

        @total_data_points.times do |i|      # generating random data points
            @dataset << DataPoint.new(10,25,40,70)
        end

        @total_data_points.times do |i|      # generating random data points
            @dataset << DataPoint.new(60,85,40,70)
        end


        @k = 4      # total number of clusters we want

        @means = Array.new()

        @k.times do |i|
            @means << DataPoint.new(1,85,1,45)
            @means[i].group = i
        end

        

        cnt = 0
        i=0
        @means.each do |mean| 
            mean.group = i
            i+=1;
        end

    end

    def update 
        
    end

    def button_down(id)
        if(id==Gosu::MS_LEFT)
            k_mean()
        end
    end
    
    def needs_cursor?; true; end

    def draw
       
            @dataset.each do |point|
        
                @k.times do |i|
                    if(i==point.group)
                        Gosu.draw_rect(point.x*10,point.y*10,5,5,@colors[i],1)
                    end
                end

            end
        
    end

    def k_mean
        
            @dataset.each do |point|
                minimun_distnace = 999
                @means.each do |mean|
                    cur_distnace = Gosu.distance(mean.x,mean.y,point.x,point.y)
                    if(cur_distnace<=minimun_distnace)
                        minimun_distnace = cur_distnace
                        point.group = mean.group
                    end
                end

            end
            
            @means.each do |mean|
                count = 1
                sum_x = 0
                sum_y = 0
                @dataset.each do |point|
                    if(point.group==mean.group)
                        sum_x+=point.x
                        sum_y+=point.y
                        count+=1
                    end
                end
                mean.x = sum_x/count
                mean.y = sum_y/count                
            end

    end 

    

end

KMean.new.show()

