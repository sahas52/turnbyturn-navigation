/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  NativeModules,
  Button,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const {TbtNavigation} = NativeModules;

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const nativeSimpleMethod = () => {
    let data = Array([
      [37.74682893940135, -122.41241455078125],
      [37.74683374310583, -122.41241505989632],
      [37.7467751, -122.4135351],
      [37.747171, -122.413571],
      [37.7473424, -122.41479700000001],
      [37.747424, -122.4148638],
      [37.7481097, -122.4149282],
      [37.7481146, -122.41501500000001],
      [37.749165000000005, -122.41611590000001],
      [37.7490303, -122.41828860000001],
      [37.752422, -122.418518],
    ]);

    let data1 = [
      [1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],
    ];
    TbtNavigation.simpleMethod(data);
  };
  const nativeSimpleMethodReturns = () => {
    TbtNavigation.simpleMethodReturns(result => {
      alert(result);
    });
  };
  const nativeSimpleMethodWithParams = () => {
    TbtNavigation.simpleMethodWithParams('example', result => {
      alert(result);
    });
  };

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />

      <Button onPress={() => nativeSimpleMethod()} title="Simple Method" />
      <Button
        onPress={() => nativeSimpleMethodReturns()}
        title="Simple Method Returns"
      />
      <Button
        onPress={() => nativeSimpleMethodWithParams()}
        title="Simple Method With Params"
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
