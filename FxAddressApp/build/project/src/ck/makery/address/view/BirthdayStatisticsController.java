package ck.makery.address.view;

import java.text.DateFormatSymbols;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.XYChart;
import ck.makery.address.model.Person;

/**
 * ���� ��� �信 ���� ��Ʈ�ѷ�
 *
 * @author Marco Jakob
 */
public class BirthdayStatisticsController {
    @FXML
    private BarChart<String, Integer> barChart;

    @FXML
    private CategoryAxis xAxis;

    private ObservableList<String> monthNames = FXCollections.observableArrayList();

    /**
     * ��Ʈ�ѷ� Ŭ������ �ʱ�ȭ�Ѵ�. �� �޼���� FXML ������ �ε�� �� �ڵ����� ȣ��ȴ�.
     */
    @FXML
    private void initialize() {
        // ���� �� �̸��� �迭�� �����´�.
        String[] months = DateFormatSymbols.getInstance(Locale.ENGLISH).getMonths();
        // ����Ʈ�� ��ȯ�ϰ� ���� ObservableList�� �߰��Ѵ�.
        monthNames.addAll(Arrays.asList(months));

        // �����࿡ �� �̸��� ī�װ��� �Ҵ��Ѵ�.
        xAxis.setCategories(monthNames);
    }

    /**
     * ��迡 ������ ����ó�� �����Ѵ�.
     *
     * @param persons
     */
    public void setPersonData(List<Person> persons) {
        // ����ó ������ �� ������ �����Ѵ�.
        int[] monthCounter = new int[12];
        for (Person p : persons) {
            int month = p.getBirthday().getMonthValue() - 1;
            monthCounter[month]++;
        }

        XYChart.Series<String, Integer> series = new XYChart.Series<>();

        // ������ XYChart.Data ��ü�� �����. series�� �߰��Ѵ�.
        for (int i = 0; i < monthCounter.length; i++) {
            series.getData().add(new XYChart.Data<>(monthNames.get(i), monthCounter[i]));
        }

        barChart.getData().add(series);
    }
}
