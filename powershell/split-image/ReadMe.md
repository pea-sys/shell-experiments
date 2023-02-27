# split-image

引数で与えたイメージを引数の分割数で分割出力します。  
引数で与えたイメージサイズが「幅 ＞ 高さ」の場合、水平方向に分割します。  
引数で与えたイメージサイズが「幅 ≦ 高さ」の場合、垂直方向に分割します。

### ■Example

```shell
split-image.ps1 <TargetFile> <SplitCount>
```

### ■input

![all_h](https://user-images.githubusercontent.com/49807271/212519481-a199a574-8cde-4aae-96ee-18364c0d7076.png)

SplitCount = 46

### ■output

![all_h0](https://user-images.githubusercontent.com/49807271/212519672-bf2d7143-5474-492f-b390-79cf0531fa04.png)
![all_h1](https://user-images.githubusercontent.com/49807271/212519674-36eaff1e-27ab-4329-9c89-a8f62a6c94af.png)
![all_h2](https://user-images.githubusercontent.com/49807271/212519678-37122501-966f-4a5e-bfc3-7b83fc7bd535.png)
![all_h3](https://user-images.githubusercontent.com/49807271/212519680-336b3659-4174-4e7e-ab31-4cbb050c46fb.png)
![all_h4](https://user-images.githubusercontent.com/49807271/212519681-bcf7153f-4ab5-4b15-be48-703f0b568d12.png) ・・・![all_v43](https://user-images.githubusercontent.com/49807271/212519697-72972282-93fe-4930-93a9-6a7cdd3b59c8.png)
![all_v44](https://user-images.githubusercontent.com/49807271/212519698-b016c4b9-1a19-4a50-92e2-c525ceabc01e.png)
![all_v45](https://user-images.githubusercontent.com/49807271/212519695-89f324de-ee6e-4708-86be-06ff812464b8.png)
