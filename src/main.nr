use dep::large_integer::LargeInteger;
use dep::rsa::verify_rsa_sha256_pkcs1v15;

fn reverse_bytes_array<N>(arr: [u8; N]) -> [u8; N] {
    let mut reversed_arr = [0 as u8; N];
    for i in 0..N {
        // Reverse
        reversed_arr[i] = arr[N - 1 - i];
    }
    reversed_arr
}

fn main(
    sig: [u8; 512],
    pubkey: [u8; 512],
    final_e: [u8; 512],
    quotient: [u8; 512],
    msg_hash: [u8; 32]
) {
    // We assume the bytes are in big endian format so we convert them to little endian

    let sig_biguint = LargeInteger::from_bytes(reverse_bytes_array(sig));
    let pubkey_biguint = LargeInteger::from_bytes(reverse_bytes_array(pubkey));
    let final_e_biguint = LargeInteger::from_bytes(reverse_bytes_array(final_e));
    let quotient_biguint = LargeInteger::from_bytes(reverse_bytes_array(quotient));

    verify_rsa_sha256_pkcs1v15(
        msg_hash,
        sig_biguint,
        pubkey_biguint,
        final_e_biguint,
        quotient_biguint
    );
}
