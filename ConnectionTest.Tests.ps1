param(
    $hostname
)
Describe "test connection to $hostname" {
    it "conncet on port 80" {
        $test = Test-NetConnection -ComputerName $hostname -Port 80
    }
}