function hashTester($runs){
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$sha = new-object -TypeName System.Security.Cryptography.SHA1CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding
$md5Queue = new-object System.Collections.Generic.List[String]
$shaQueue = new-object System.Collections.Generic.List[String]
runHash $md5 $md5Queue $runs;
runHash $sha $shaQueue $runs;
"SHA1"
$shaQueue | group-object | FT -a -p Name,Count
"MD5"
$md5Queue | group-object | FT -a -p Name,Count
}

function runHash($alg,$col,$runs)
{
for($i = 0; $i -lt 10000; $i++)
{
	$server = "WDDCEPSCDWEB" + $i;

	$col.Add([System.BitConverter]::ToUInt64($alg.ComputeHash($utf8.GetBytes($server)),2) % $runs);

}

}
