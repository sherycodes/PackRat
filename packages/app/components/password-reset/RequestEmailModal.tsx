import React from 'react';
import { BaseModal, RInput } from '@packrat/ui';
import useCustomStyles from 'app/hooks/useCustomStyles';
import { useRequestEmailModal } from 'app/hooks/password-reset';

export const RequestPasswordResetEmailModal = () => {
  const styles = useCustomStyles(loadStyles);
  const { email, setEmail, loading, handleResetPasswordEmail } =
    useRequestEmailModal();

  return (
    <BaseModal
      title="Reset Password"
      trigger="Request Password Reset Email"
      footerButtons={[
        {
          label: 'Send Email',
          color: '#818cf8',
          onClick: handleResetPasswordEmail,
          disabled: !email || loading,
        },
        {
          label: 'Cancel',
          color: '#B22222',
          onClick: (_, closeModal) => {
            closeModal();
          },
        },
      ]}
    >
      <RInput
        placeholder="Email"
        autoCapitalize="none"
        keyboardType="email-address"
        value={email}
        onChangeText={(value) => {
          setEmail(value);
        }}
      />
      {/* <Center w="100%">
                <Box safeArea p="2" py="8" w="90%" maxW="290">
                    {/* <Heading
                        size="lg"
                        fontWeight="600"
                        color="coolGray.800"
                        _dark={{
                            color: "warmGray.50",
                        }}
                    >
                        <Text>Reset Password</Text>
                    </Heading>

                    <VStack space={1} mt="5">
                        <View style={styles.container}>

                            <Button
                                block
                                style={styles.button}
                                onPress={handleResetPasswordEmail}
                                disabled={!email || loading}
                            >
                                <Text>{loading ? 'Loading...' : 'Request Password Reset Email'}</Text>
                            </Button>
                        </View>
                    </VStack>
                </Box>

            </Center> */}
    </BaseModal>
  );
};

const loadStyles = () => ({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
  },
  button: {
    marginTop: 20,
  },
  resetForm: {
    marginTop: 20,
  },
});
