/*
 * JavaScript client-side example using jsrsasign
 */

var privateKey = "-----BEGIN PRIVATE KEY-----\n" +
"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8Fxfrev/LqmJx\n" +
"AlErtDn0LEmWDQa64fs4Q2y/tE/R0FeIxedB8rSdotrdjxy1pXPNTOdd+fzdx1uz\n" +
"s75nU43toLS81MUkW2G27xs8Ta0zs4xy+z1FVNiG78dACQpYkqV2KYywI0qPpgA1\n" +
"7ZhZXHrOUvZs07rHPm31I8GFBH1Rbk43cnSsYSLUUBR9WqNTrcnJj8BTlsyJInRo\n" +
"jcByj9DXXpZdg+/fdA/KTrT6KZtqEjzY7kmp6aSAHkLFAoS6KtfTqfPXpBYSNsqm\n" +
"6qtQExoy0km7Q2/bcVBl0XPU6zK5hPca6aGmtPuYbVVt4QGWPojDV1cYdxKZCrWH\n" +
"f7teUBZPAgMBAAECggEBAJ03BFRc5BBdY5koIabRJxvUJNHaI4TzvKNjoDOAyLMM\n" +
"XQ5CtTDnaFbWt/A3XfzqxaeVn1Jq0RSjPSAwnncJXPmBuXCYvAvOohdhNreqCZrM\n" +
"ehnlrGoWKEJpi3cX12D/enQQ+LqFVR5K16Q763rOFQv+RmHifB1sLkaX03qWrRTx\n" +
"GPpQpD5dZuZDkpkBb8s00X1OO2+v4A9a7oYXK1RRHbysChvGdIyzm64fD2xvFoww\n" +
"7IJHBa3P+BVekhydFWzvMRjd8BtWICYrmIquKtlnesp8DdCMpKF8zc+tSe48dtG6\n" +
"QeAWyrlNL2NuzgSEuz3frTZziXNSykCBNkH6D+/gn8ECgYEA8Aloqkvbq80HV20U\n" +
"llcA57sjhYHslW6165+7FbuI2MOr+mF0Fvd+NQc1bKJm7POyfb5Ocpk9zMCl2Q5z\n" +
"BaFSuI9whQgpXNtpPiOrQccyRwjNb2LRHo1y7/7LG26+l+GJz4jQ8UZAYTtQgFZ3\n" +
"oYSxLtyTHP599C9F/FZJCUxO868CgYEAyJlNWaR1iEivYlGmCq9KpE/Sk6ZhDjhL\n" +
"vzDyLVdnfdtDgIeazpr4pu55HHjV+38Ed/JwztdBpry5XEzBbROd10mmYKPBMxox\n" +
"q+gjA8Bu42ilmsC0zduDjjjdq6gW8ZkuOy7ZwkU/cNHVKQJBtFz3SSII5uOPfCdr\n" +
"Sobs83Dpj2ECgYAaMtyyoZ7zTGh9uVEi65IUuM8ytjCNSs0eT4vK3nIcPpcZt+NE\n" +
"0nR68zN4jO0w9ZRItym2xlUBcRFo9HPHbIkrzbQZQP/Ku8Pr3VbG0igBqstJWf67\n" +
"F/MwkJ24e8jfqOUyupsbinBibGfn6ggan/H6zGZeJsS2jyZTWVOVaTfAzwKBgCNe\n" +
"PDAY+gwMXLfmE3OA0pVD6anUxPn/3QMZuylZZsre9Pjdb+MLmdm85Cer+nZ8P6py\n" +
"WYdulomybrAibFwyADtsJeSWGsNK1AUuSbYooKSB1+kAHyDImlpiFltkqJ7yVh9j\n" +
"NEu3b+cRaBbx6enGFmeTk6Q57RuDy7v5LCAEAXohAoGBAM40oGC5tuIH5ftNv9X7\n" +
"zOXtamrzjMQazCh/JMAl27sjkq/TmyfgTJ+ogudjhK+zZlLK/0AKmi6efFxbScId\n" +
"RaXKi3cguAdi3ugtCzZPZfB4xmFtBNZCAe4YYBXgGGzvEXNVewniP4iCbWKwEjzQ\n" +
"7/U4CahO/p9LRDfOgnQAUGd1\n" +
"-----END PRIVATE KEY-----\n";


ep.security.setSignatureAlgorithm("SHA512"); // Since 2.1
ep.security.setSignaturePromise(function(toSign) {
    return function(resolve, reject) {
        try {
            var pk = KEYUTIL.getKey(privateKey);
            var sig = new KJUR.crypto.Signature({"alg": "SHA512withRSA"});  // Use "SHA1withRSA" for 2.0 and older
            sig.init(pk); 
            sig.updateString(toSign);
            var hex = sig.sign();
            console.log("DEBUG: \n\n" + stob64(hextorstr(hex)));
            resolve(stob64(hextorstr(hex)));
        } catch (err) {
            console.error(err);
            reject(err);
        }
    };
});
